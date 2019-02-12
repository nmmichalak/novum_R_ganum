# packages
library(tidyverse)
library(weightr)
library(compute.es)

# p-curve functions
source("/Users/nicholasmichalak/Google Drive/Neil & Nick/StereotypeThreat_P-CurveMeta/analysis/meta_functions/pcurve_test.R")
source("/Users/nicholasmichalak/Google Drive/Neil & Nick/StereotypeThreat_P-CurveMeta/analysis/meta_functions/pcurve_d.R")

# simulation function
sim_d <- function(d_mean, d_sd, n0, n1) {
  
  # 1 random sample, d ~ N(d_mean, d_sd)
  di <- rnorm(n = 1, mean = d_mean, sd = d_sd)
  
  # if smallest and largest cell size considered are exactly equal, use n0
  if(n0 == n1) {
    ni <- n0
  }
  
  # else, calculate n0 and n1, cell sizes for each power level
  else {
    ni <- sample(n0:n1, size = 1, replace = TRUE)
  }
  
  # calculate observed degree of freedom, dfi
  dfi <- 2 * (ni - 1)
  
  # calculate critical t-value, tcriti
  tcriti <- qt(1 - 0.05 / 2, dfi)
  
  # calculate noncentrality parameter, ncpi
  ncpi <- sqrt(ni / 2) * di
  
  # calculate power, pwri
  pwri = 1 - pt(q = tcriti, df = dfi, ncp = ncpi)
  
  # from simonsohn: "Once we know power, we know that every
  # t-value above the power_th percentile of them, under the ncp,
  # will give a p < .05 if we evaluate it with the central t so we
  # draw only from that range." (random p-values from the noncentral, rpi)
  rpi <- runif(n = 1, min = 1 - pwri, max = 1)
  
  # calculate observed t-statistic, ti
  ti <- qt(p = rpi, df = dfi, ncp = ncpi)
  
  # return list with these values
  list(ti = ti, dfi = dfi, di = di)
}

# parameters
mean_d <- 0.35
sd_d <- 0.20
n0 <- power.t.test(delta = mean_d, power = 0.50)$n
n1 <- power.t.test(delta = mean_d, power = 0.80)$n

# simulation data
simdat <- replicate(n = 10000, sim_d(d_mean = mean_d, d_sd = sd_d, n0 = n0, n1 = n1), simplify = FALSE)

# t-stat
ti <- map_dbl(simdat, function(x) x[["ti"]])

# df
dfi <- map_dbl(simdat, function(x) x[["dfi"]])

# one-tailed p-value
p1ti <- 1 - pt(q = ti, df = dfi)

# two-tailed p-value
p2ti <- 2 * (1 - pt(q = abs(ti), df = dfi))

# cohen's d
di <- tes(t = ti, n.1 = (dfi + 2) / 2, n.2 = (dfi + 2) / 2, dig = Inf, verbose = FALSE)$d

# cohen's d variance
vi <- tes(t = ti, n.1 = (dfi + 2) / 2, n.2 = (dfi + 2) / 2, dig = Inf, verbose = FALSE)$var.d

# p-curve estimate
pcurve_d(ti = ti, dfi = dfi, dmin = 0.00, dmax = 0.80)

# weight function model estimate
weightfunct(effect = di[p1ti < 0.025], v = vi[p1ti < 0.025], steps = c(0.025, 1), table = TRUE, pval = p1ti[p1ti < 0.025])
