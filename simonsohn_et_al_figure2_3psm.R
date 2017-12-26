#R Code behind Figure 2 in
#Simonsohn, Simmons and Nelson,  "P-Curve and Effect Size: Correcting for Publication Bias Using Only Significant Results"
#
#Prepared by Uri Simonsohn, uws@wharton.upenn.edu
#
#Last updated: 2014 05 13
##########################################################


#####################################################################################################
#SIMPLIFIED LOSS FUNCTION, USED THROUGHOUT BELOW
#see appendix in paper for explanations and more robust version (robust to user input with t<0 and/or p>.05)
loss=function(t_obs,df_obs,d_est) {  
  ncp_est=sqrt((df_obs+2)/4)*d_est
  tc=qt(.975,df_obs)              
  power_est=1-pt(tc,df_obs,ncp_est)
  p_larger=pt(t_obs,df=df_obs,ncp=ncp_est)  
  ppr=(p_larger-(1-power_est))/power_est 	
  KSD=ks.test(ppr,punif)$statistic       	
  return(KSD)     }
######################################################################################
# function for extracting model estimates from weightfunct()
weightfun_est <- function(mod) {
  output_unadj <- mod[[1]]
  output_adj <- mod[[2]]
  list(unadj_est = c(output_unadj$par), 
       unadj_se = c(sqrt(diag(solve(output_unadj$hessian)))), 
       adj_est = c(output_adj$par), z_unadj = c(output_unadj$par/sqrt(diag(solve(output_unadj$hessian)))), 
       p_unadj = c(2 * pnorm(-abs(output_unadj$par/sqrt(diag(solve(output_unadj$hessian)))))), 
       ci.lb_unadj = c(output_unadj$par - qnorm(0.975) * 
                         sqrt(diag(solve(output_unadj$hessian)))), 
       ci.ub_unadj = c(output_unadj$par + qnorm(0.975) * 
                         sqrt(diag(solve(output_unadj$hessian)))))
}
######################################################################################

library(metafor)  #this is the meta-analysis package that contains rma() function
library(weightr) # contains three-paramter selection method

library(tidyverse) # for pipes %>% and ggplot2

f2=function(n0,n1,ki,d_mean,d_sd) {
  #SYNTAX
  # n0 is the smallest sample size considered 
  # n1 is the largest sample size in the set
  # ki is the number of p<.05 studies of a given sample size, e.g., if ki=100 and n0=20 and n1=25, there will 100 n=20 studies, 100 n=21, 100 n=22, etc.
  # d_mean is the average  of the true effect size being simulated, cohen-d
  # d_sd is the stadnard deviation of the true effect size being simulated.
  #      to simulate studies from the exact same effect size we set d_sd=0
  
  #EXPLANATION:
  #   This program generates Figure 2 which shows naive, trim-and-fill corrected, and p-curve based effect size estimates
  #   It generates significant studies with samples sizes between n=n0 and n=n1, the same number of each, where the true effect size is d~N(d_mean,d_sd)
  #
  #STEPS
  #   1) Generate the sample sizes to be used
  #   2) Draw true effect sizes from a population distribution N(d_mean,d_sd), one effect size is drawn per simulated study
  #   3) Generate only significant t-tests, under the noncentrality parameter (ncp) implied by the sample sizes and true ds
  #   4) Compute p-curve's estimate by minimizing loss for those t-tests
  #   5) Convert ts into ds
  #   6) Use metaanalysis to compute the naive d and the trim and fill correction
  
  #SET SEED TO ALWAYS GET SAME RESULT
  
  set.seed(150*d_mean) #set seed as a function of d_mean so that the results are always the same, but across different settings the seed varies
  
  #1) Generate the sample sizes to be used
  ni=rep(n0:n1,each=ki)            #vector ni has one scalar per study, the first ki elements are n0, the next ki are n0+1....
  df=2*ni-2                        #degrees of freedom, is a vector 
  
  #2) true d
  di=rnorm(n=ki*(n1-n0+1),mean=d_mean,sd=d_sd)
  
  #3) Generate significant t-tests
  tc=qt(.975,df)                                    #3.1 critical t-test that is significant with the sample size
  ncpi=sqrt(ni/2)*di                                #3.2 noncentarlity parameter used to draw from noncentral t, vector as different ncp for each n
  poweri=1-pt(tc,df=df,ncp=ncpi)                    #3.3 power is computed to use in the next line to generate only p<.05 t-values
  rp=runif(n=(n1-n0+1)*ki,min=1-poweri,max=1)       #3.4 generates the randomly draw "p"-values from a uniform (p-values but computed with the noncentral
  #   This latter step is a bit tricky if you are not familiar with noncentral distributions
  #   Once we know power, we know that every t-value above the power_th percentile of them, under the ncp, 
  #   will give a p<.05 if we evaluate it with the central t so we draw only from that range.
  #    Example. Say that for a given n=20 & d=5-->power =33%. To draw significant t-values under the null of d=.5, then,
  #    we compute the inverse of randomly drawn uniform values between .67 and 1 (the biggest third) form the qt(rt(min=.67,max=1),ncp=sqrt(20/2)*.5, df=38). .
  
  t_publish=qt(p=rp,df=df,ncp=sqrt(ni/2)*di)        #t-values associated with those uniform cdf values
  
  #4) Find d-hat for p-curve 
  dp=optimize(loss,c(-.3,2),df_obs=df,t_obs=t_publish)$minimum  #optimize misbehaves very far from the truth, so constrained to -.3,2
  
  #5) #Convert t-values into d-values using formula: d=2*t/sqrt(N) -shown in main paper, see footnote 
  d_publish=(2*t_publish)/sqrt(df+2)
  
  #6) Meta-analysis estimates
  
  #6.1) Compute the variance of each d-value in the set. 
  #the variance of a standardized coefficient depends only on sample size and the coefficient.
  #I use the formula provided in the Meta-analysis book by Hedges and Olkin (1985), "Statistical Methods for Meta-Analysis", page 80, Equation 8
  #var(g=1/n~ + (d**2)/(2*(N-3.94))
  #  Where:
  #        g is what I refer to as d here, the standardized difference of means
  #        n~ is n1*n2/(n1+n2) and n1,n2 refer to sample sizes of each samples, if n1=n2 then n~=n**2/2*n=n/2   [sorry, ~ is not approximate, but tilde]
  #        N is the total n, if n1=n2 then N=2n
  vard_publish= 2/ni +(d_publish**2)/(2*(ni-3.94))   #this is var(d)
  
  #6.2) Run the standard meta-analysis routine                                    
  naive=rma(yi=d_publish,vi=vard_publish,method="FE")   #once again, you need to load metafor() to run RMA
  #this will run a fixed-effect meta-analysis (hence method="FE"
  #using as the d.v. the d_publish vector and as the variance, its variance vard_publish)
  
  #6.3) fit the three-parameter selection model
  tpsm=weightfun_est(weightfunct(effect = d_publish, v = vard_publish))
  
  
  #Report results as they are being computed
  cat("# tests       ",length(t_publish))
  cat("\n naive estimate:   ",naive$b)                   #the $b indicates that from the vector naive we just want the point estimate, $b
  cat("\n three parameter selection:    ",tpsm$adj_est[2])
  cat("\n p-curve:          ",dp)
  cat("\n mean(di)=",mean(di),"    sd(di)=",sd(di) )     #this verifies the simulation obtained the desired distribution of true-effect sizes
  cat("\n =========================================== \n")
  return(c(naive$b,tpsm$adj_est[2],dp)) #Return results as vector of point estimate by the navie method of average p<.05, the three-parameter selection adjustment, and p-curves
}




#mat() is a function that runs the tf() function for d=[0,.8] and saves results into a matrix
mat=function(ki,n0,n1,d_sd) {
  #Run the tf() for d=(0,.2,.4,.6,.8)
  r1=f2(ki=ki,n0=n0,n1=n1,d_mean=.0,d_sd=d_sd) 
  r2=f2(ki=ki,n0=n0,n1=n1,d_mean=.2,d_sd=d_sd) 
  r3=f2(ki=ki,n0=n0,n1=n1,d_mean=.4,d_sd=d_sd) 
  r4=f2(ki=ki,n0=n0,n1=n1,d_mean=.6,d_sd=d_sd) 
  r5=f2(ki=ki,n0=n0,n1=n1,d_mean=.8,d_sd=d_sd) 
  r=c(r1,r2,r3,r4,r5)
  return(matrix(r,5,3,byrow=TRUE))
}


#Fig 2A: n=20, sd(d)=0
m20=mat(ki=5000,n0=20,n1=20,d_sd=0)       
#Fig 2B: n=U[5-35], sd(d)=0
m5_35=mat(ki=161,n0=5,n1=35,d_sd=0)       #NOte, with 161 studies per sample-size, the total number of studies is ~5000
#Fig 2C: n=U[5-35], sd(d)=.1  
m5_35sd2=mat(ki=161,n0=5,n1=35,d_sd=.2)       


#I copy pasted the results into excel to plot Figure 2

#Note: R gives a lot of warnings when using the non-central student distribution. These warnings point to trivial discrepancies
#      in precision way outside the range we may care about. Ignoring them is, apparently, the best thing to do.

rbind(m20, m5_35, m5_35sd2) %>% 
  as_tibble() %>% 
  set_names(nm = c("Average significant effect", "Three-parameter selection", "p-Curve")) %>% 
  mutate("Average true effect" = seq(0, 0.8, 0.2) %>% rep(times = 3),
         mean_d = seq(0, 0.8, 0.2) %>% rep(times = 3),
         conditions = c("Predetermined N = 40, Fixed di", "Predetermined N = 40-70, Fixed di", "Predetermined N = 40-70, di ~ N(d, 0.20)") %>% rep(each = 5)) %>% 
  gather(key = method, value = estimate, -c(mean_d, conditions)) %>% 
  ggplot(mapping = aes(x = mean_d, y = estimate, color = method, group = method)) +
  geom_line(size = 1) +
  geom_point(stat = "identity", size = 5, shape = 15) +
  facet_wrap(facets = ~ conditions) +
  scale_color_manual(values = c("lightblue", "grey", "red", "black")) +
  scale_y_continuous(breaks = seq(0.00, 0.80, 0.20), limits = c(-0.2, 1.2)) +
  labs(x = "Average true effect", y = "Cohen's d", color = NULL) +
  theme_bw() +
  guides(linetype = FALSE) +
  theme(legend.position = "top")
