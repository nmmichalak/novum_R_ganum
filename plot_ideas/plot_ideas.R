# set randomizer seed so results can be reproduced
set.seed(1234)

# tibble with two conditions and 12 DVs
dat <- tibble(group = factor(rep(c("control", "treat"), each = 100)))
dat[, paste0("dv_", 1:12)] <- list(m = sample(1:7, size = 12, replace = TRUE),
                                   s = sample(1:2, size = 12, replace = TRUE)) %>%
  pmap(function(m, s) rnorm(n = 200, mean = m, sd = s))

# plot idea
dat %>%
  gather(dv, value, -group) %>%
  ggplot(mapping = aes(x = group, y = value, color = group)) +
  geom_violin() +
  geom_jitter(alpha = 0.2) +
  stat_summary(fun.data = "mean_cl_normal", geom = "errorbar", color = "black", width = 0.1) +
  stat_summary(fun.data = "mean_cl_normal", geom = "point", size = 2) +
  facet_wrap(~ dv)
