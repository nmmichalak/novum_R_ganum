# packages
library(lavaan)
library(boot)

# write function
standardized_estimate <- function(data, obs) {
  # write model
  model <- "# latent variables
            visual =~ x1 + x2 + x3
            textual =~ x4 + x5 + x6
            speed =~ x7 + x8 + x9"
  
  # fit model with one observation
  fit <- cfa(model, data = data[obs, ])
  
  # get estimate from standardized solution
  standardizedsolution(fit)$est
}

# get bootstraps
boot_out <- boot(data = HolzingerSwineford1939, statistic = standardized_estimate, R = 2000)

# see estimates from the model using all observations
fit <- cfa(model, data = HolzingerSwineford1939)
standardizedsolution(fit)

# here's boot.ci for just the fifth parameter
boot.ci(boot_out, type = "bca", index = 5)

# get bias-corrected CI for the first index
lapply(1:5, function(i) boot.ci(boot_out, type = "bca", index = i))

