# packages
library(tidyverse)
library(psych)
library(compute.es)

# p-curve test function
source("~/Google Drive/Neil & Nick/StereotypeThreat_P-CurveMeta/analysis/meta_functions/pcurve_test.R")

# p-curve effect size estimate, d
source("/Users/nicholasmichalak/Google Drive/Neil & Nick/StereotypeThreat_P-CurveMeta/analysis/meta_functions/pcurve_d.R")

# simulation function
sim_fun <- function(k, nmin, nmax, d1, d2) {
  # range of cell sizes
  n_range <- seq(nmin, nmax, 1)
  
  # select cell size 1 and 2
  n1 <- sample(n_range, size = k, replace = TRUE)
  n2 <- sample(n_range, size = k, replace = TRUE)
  
  # compute df
  df <- n1 + n2 - 4
  
  # calculate critical t-value, tcrit
  tcrit <- qt(p = 1 - 0.05 / 2, df = df)
  
  # calculate noncentrality parameter, ncp
  ncp1 <- sqrt((n1 + n2) / 4) * d1
  ncp2 <- sqrt((n1 + n2) / 4) * d2
  
  # calculate power, pwr
  pwr1 <- 1 - pt(q = tcrit, df = df, ncp = ncp1)
  
  # from simonsohn: "Once we know power, we know that every
  # t-value above the power_th percentile of them, under the ncp,
  # will give a p < .05 if we evaluate it with the central t so we
  # draw only from that range." (random p-values from the noncentral, rp)
  rp1 <- runif(n = k, min = 1 - pwr1, max = 1)
  
  # calculate observed t-statistic, t
  t1 <- qt(p = rp1, df = df, ncp = ncp1)
  
  # the other effect is not selected for signifigance
  t2 <- rt(n = k, df = df, ncp = ncp2)
  
  # return ns, df, and ts
  data.frame(n1 = n1, n2 = n2, df = df, t1 = t1, t2 = t2)
}

# hedges g function
hedges_g <- function(n1, n2, t) {
  # cohen's d
  d <- t * sqrt((n1 + n2) / (n1 * n2))
  
  # d variance
  var_d <- ((n1 + n2) / (n1 * n2)) + d^2 / (2 * (n1 + n2))
  
  # degrees of freedom
  df <- n1 + n2 - 2
  
  # correction factor
  j <- 1 - (3 / (4 * df - 1))
  
  # unbiased d, g
  g <- d * j
  
  # g variance
  var_g <- var_d * j^2
  
  # return d, g, and their variances
  list(d = d, var_d = var_d, g = g, var_g = var_g)
}

# compare 2 independent gs or ds to eachother
compare_g <- function(d1, d2, v1, v2) {
  # test statistic, z
  z <- (d1 - d2) / sqrt(v1 + v2)
  
  # p-value (one-tailed)
  p <- 1 - pnorm(q = z)
  
  # return z and p
  list(z = z, p = p)
}

# replicate
sim_data <- sim_fun(k = 10000, nmin = 20, nmax = 100, d1 = 0, d2 = 0)

# compute hedges's gs
sim_data$g1 <- with(sim_data, hedges_g(n1 = n1, n2 = n2, t = t1)$g)
sim_data$g2 <- with(sim_data, hedges_g(n1 = n1, n2 = n2, t = t2)$g)

# compute hedges's g variances
sim_data$var_g1 <- with(sim_data, hedges_g(n1 = n1, n2 = n2, t = t1)$var_g)
sim_data$var_g2 <- with(sim_data, hedges_g(n1 = n1, n2 = n2, t = t2)$var_g)

# compute simple effect p-values (one-tailed)
sim_data$p1 <- with(sim_data, 1 - pt(q = t1, df = df))
sim_data$p2 <- with(sim_data, 1 - pt(q = t2, df = df))

# test differences in effect size (i.e., the interaction)
sim_data$z <- with(sim_data, compare_g(d1 = g1, d2 = g2, v1 = var_g1, v2 = var_g2)$z)
sim_data$p <- with(sim_data, compare_g(d1 = g1, d2 = g2, v1 = var_g1, v2 = var_g2)$p)

# test p-curve when simple effect is significant (ignore interaction)
with(sim_data, pcurve_test(pi = p1 * 2, dfi = df))

# estimate p-curve effect size when simple effect is significant (ignore interaction)
with(sim_data, pcurve_d(ti = t1, dfi = df, dmin = -1, dmax = 1))

# flag significant interaction
sim_data$sig_int <- with(sim_data, p < 0.025)

# test p-curve for simple effect ONLY when interaction is significant
with(sim_data, pcurve_test(pi = p1[sig_int] * 2, dfi = df[sig_int]))

# estimate p-curve for simple effect size ONLY when interaction is significant
with(sim_data, pcurve_d(ti = t1[sig_int], dfi = df[sig_int], dmin = -1, dmax = 1))
