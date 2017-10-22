source("/Users/nicholasmichalak/Desktop/analysis-examples/Handy R Functions/test_logit.R")

# population proportions
p <- 1:9 / 10

# sample sizes
n <- c(20, 40, 80, 250)

# specification grid
spec_grid <- expand.grid(p = p, n = n)

# number of replications per simulation
repl <- 1000

sim_fun <- function(i) {
  
  data.frame(
    
    x = rbinom(n = spec_grid[i, "n"], size = 1, prob = spec_grid[i, "p"]),
    spec = i
    
  )
  
}

sim_dat <- replicate(n = repl, expr = (
  
  lapply(1:nrow(spec_grid), function(j) sim_fun(j))
  
))

sim_table <- do.call(rbind, apply(sim_dat, 2, function(x) do.call(rbind, x)))

spec_grid$spec <- as.numeric(rownames(spec_grid))
sim_table <- merge(sim_table, spec_grid, by = "spec")
sim_table$repl <- rep(1:1000, each = sum(spec_grid$n))

logit_out <-          
lapply(1:36, function(i) {
  
  lapply(1:repl, function(r) {
    
    with(data = sim_table[sim_table$spec == i & repl == r, ],
         test_logit(p = mean(x), n = length(x), cntr = 1, alpha = 0.5))
    
  })
  
})

student_out <-          
  lapply(1:36, function(i) {
    
    lapply(1:repl, function(r) {
      
      with(data = sim_table[sim_table$spec == i & repl == r, ],
           t.test(x, mu = 0.5))
      
      })
    
  })
