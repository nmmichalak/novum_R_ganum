# learn R for psychology research: a crash course
Nicholas Michalak  
October 21, 2017  

# introduction
> I wrote this for psychologists who want to learn how to use R in their research **right now.** What does a psychologist need to know to use R to import, wrangle, plot, and model their data today? Here we go.

# foundations: resources that inspired me.
> * [Dan Robinson (July 05, 2017)](http://varianceexplained.org/r/teach-tidyverse/) convinced me that beginneRs should learn tidyverse first, not Base R. I wrote this tutorial with this in mind. All you need to know about the differnece is in his blog post. If you've learned some R before this, you might understand that difference as you go through this tutorial.
> * If you want a more detailed introduction to R, start with [R for Data Science (Wickham & Grolemund, 2017)](http://r4ds.had.co.nz/). The chapters are short, easy to read, and filled with simple coding examples that demonstrate big principles. And **it's free.**
> * Hadley Wickham is a legend in the R community. He's responsible for the tidyverse, including ggplot2. Read his books and papers (e.g., [Wickham, 2014](http://vita.had.co.nz/papers/tidy-data.html)). Watch his talks (e.g., [ReadCollegePDX, October 19, 2015](https://youtu.be/K-ss_ag2k9E?list=PLNtpLD4WiWbw9Cgcg6IU75u-44TrrN3A4)). He's profoundly changed how people think about structuring and visualizing data.

# need-to-know basics

## Install R and R Studio (you need both in that order)
> * Installing (and uninstalling) R and R Studio
> * Installing R ( [Macintosh](https://stats.idre.ucla.edu/r/icu/installing-r-for-macintosh/) / [Windows](https://stats.idre.ucla.edu/r/icu/installing-r-for-windows/))
> * Uninstalling R ( [Macintosh](https://cran.r-project.org/doc/manuals/r-release/R-admin.html#Uninstalling-under-macOS) / [Windows](https://cran.r-project.org/doc/manuals/r-release/R-admin.html#Uninstallation))
> * [Installing R Studio](https://www.rstudio.com/products/rstudio/download/)
> * [Uninstalling R Studio](https://support.rstudio.com/hc/en-us/articles/200554736-How-To-Uninstall-RStudio-Desktop)

## understand all the panels in R Studio
![Four panels in R Studio](r_studio_panels_tutorial.png)

## packages
> "Packages are collections of R functions, data, and compiled code in a well-defined format. The directory where packages are stored is called the library. R comes with a standard set of packages. Others are available for download and installation. Once installed, they have to be loaded into the session to be used." **Source:** https://www.statmethods.net/interface/packages.html


```r
# before you can load these libraries, use need to install them first:
# install.packages(tidyverse)
# install.packages(haven)
# install.packages(psych)
# install.packages(car)

library(tidyverse)
library(haven)
library(psych)
library(car)
```

## objects
> "`object <- fuction(x)`, which means 'object is created from function(x)'. An object is anything created in R. It could be a variable, a collection of variables, a statistical model, etc. Objects can be single values (such as the mean of a set of scores) or collections of information; for example, when you run an analysis, you create an object that contains the output of that analysis, which means that this object contains many different values and variables. Functions are the things that you do in R to create your objects." **Source:** Field, A., Miles., J., & Field, Z. (2012). Discovering statistics using R. London: SAGE Publications.

## `c()` function
> "c" stands for combine. Use this to combine values into a vector. "A vector is a sequence of data 'elements' of the same basic type." **Source:** http://www.r-tutor.com/r-introduction/vector
> Below, we create an object called five_numbers. We are naming it for what it is, but we could name it whatever we want: some_numbers, maple_tree, platypus. It doesn't matter. We'll use this in the examples in later chunks of code.


```r
five_numbers <- c(1, 2, 3, 4, 5)

# print five_numbers by just excecuting/running the name of the object
five_numbers
```

```
## [1] 1 2 3 4 5
```

## R Help: `help()` and `?`
> "The help() function and ? help operator in R provide access to the documentation pages for R functions, data sets, and other objects, both for packages in the standard R distribution and for contributed packages. To access documentation for the standard lm (linear model) function, for example, enter the command help(lm) or help("lm"), or ?lm or ?"lm" (i.e., the quotes are optional)." **Source:** https://www.r-project.org/help.html

## piping, `%>%`
> The `%>%` operator allows you to "pipe" a value forward into an expression or function; something along the lines of x `%>%` f, rather than f(x). See http://magrittr.tidyverse.org/articles/magrittr.html for more details, but check out these examples below.

## compute z-scores for those five numbers, called five_numbers


```r
five_numbers %>% scale()
```

```
##            [,1]
## [1,] -1.2649111
## [2,] -0.6324555
## [3,]  0.0000000
## [4,]  0.6324555
## [5,]  1.2649111
## attr(,"scaled:center")
## [1] 3
## attr(,"scaled:scale")
## [1] 1.581139
```

## compute z-scores for five_numbers and then convert the result into only numbers


```r
five_numbers %>% scale() %>% parse_number()
```

```
## [1] -1.2649111 -0.6324555  0.0000000  0.6324555  1.2649111
```

## compute z-scores for five_numbers and then convert the result into only numbers and then compute the mean


```r
five_numbers %>% scale() %>% parse_number() %>% mean()
```

```
## [1] 0
```

## tanget: most R introductions will teach you to code the example above like this:


```r
mean(parse_number(scale(five_numbers)))
```

```
## [1] 0
```

> * I think this is counterintuitive. You're reading the current sentence from left to right. That's how I think code should read like: how you read sentences. Forget this "read from the inside out" way of coding for now. You can learn the "read R code inside out" way when you have time and feel motivated to learn harder things. I'm assuming you don't right now.

## functions
> "A function is a piece of code written to carry out a specified task; it can or can not accept arguments or parameters and it can or can not return one or more values." Functions **do** things for you. **Source:** https://www.datacamp.com/community/tutorials/functions-in-r-a-tutorial#what

## compute the num of five_numbers


```r
five_numbers %>% sum()
```

```
## [1] 15
```

## compute the length of five_numbers


```r
five_numbers %>% length()
```

```
## [1] 5
```

## compute the sum of five_numbers and divide by the length of five_numbers


```r
five_numbers %>% sum() / five_numbers %>% length()
```

```
## [1] 3
```

## define a new function called compute_mean


```r
compute_mean <- function(some_numbers) {
  some_numbers %>% sum() / some_numbers %>% length()
}
```

## compute the mean of five_numbers


```r
five_numbers %>% compute_mean()
```

```
## [1] 3
```

# create data for psychology-like examples
> This is the hardest part of the tutorial.

## subject numbers


```r
subj_num <- seq(from = 1, to = 100, by = 1)

# print subj_num by just excecuting/running the name of the object
subj_num
```

```
##   [1]   1   2   3   4   5   6   7   8   9  10  11  12  13  14  15  16  17
##  [18]  18  19  20  21  22  23  24  25  26  27  28  29  30  31  32  33  34
##  [35]  35  36  37  38  39  40  41  42  43  44  45  46  47  48  49  50  51
##  [52]  52  53  54  55  56  57  58  59  60  61  62  63  64  65  66  67  68
##  [69]  69  70  71  72  73  74  75  76  77  78  79  80  81  82  83  84  85
##  [86]  86  87  88  89  90  91  92  93  94  95  96  97  98  99 100
```

## condition assignments


```r
condition <- c("control", "manipulation") %>% rep(each = 50) %>% factor()

# print condition by just excecuting/running the name of the object
condition
```

```
##   [1] control      control      control      control      control     
##   [6] control      control      control      control      control     
##  [11] control      control      control      control      control     
##  [16] control      control      control      control      control     
##  [21] control      control      control      control      control     
##  [26] control      control      control      control      control     
##  [31] control      control      control      control      control     
##  [36] control      control      control      control      control     
##  [41] control      control      control      control      control     
##  [46] control      control      control      control      control     
##  [51] manipulation manipulation manipulation manipulation manipulation
##  [56] manipulation manipulation manipulation manipulation manipulation
##  [61] manipulation manipulation manipulation manipulation manipulation
##  [66] manipulation manipulation manipulation manipulation manipulation
##  [71] manipulation manipulation manipulation manipulation manipulation
##  [76] manipulation manipulation manipulation manipulation manipulation
##  [81] manipulation manipulation manipulation manipulation manipulation
##  [86] manipulation manipulation manipulation manipulation manipulation
##  [91] manipulation manipulation manipulation manipulation manipulation
##  [96] manipulation manipulation manipulation manipulation manipulation
## Levels: control manipulation
```

## dependent measure

### save 5 values that represent the sample sizes and the true means and standard deviations of our pretend conditions


```r
sample_size <- 50
control_mean <- 2.5
control_sd <- 1
manip_mean <- 5.5
manip_sd <- 1
```

### introduce a neat function in R: `rnorm()`
> rnorm stands for random normal. Tell it sample size, true mean, and the true sd, and it'll draw from that normal population at random and spit out numbers.


```r
# for example
rnorm(n = 10, mean = 0, sd = 1)
```

```
##  [1] -0.90958015 -2.83969170 -0.56747034  0.12375479  0.03588964
##  [6]  1.83686488 -1.24858855 -1.83152841 -3.05360029  0.57755650
```

### randomly sample from our populations we made up above


```r
control_values <- rnorm(n = sample_size, mean = control_mean, sd = control_sd)

manipulation_values <- rnorm(n = sample_size, mean = manip_mean, sd = manip_sd)
```

### combine those and save as our dependent variable


```r
dep_var <- c(control_values, manipulation_values)

# print dep_var by just excecuting/running the name of the object
dep_var
```

```
##   [1] 3.8961988 2.6461046 4.1539669 1.1631392 2.2008941 3.4340587 1.9553243
##   [8] 0.2393393 2.2226448 2.9746707 1.3610645 2.2422547 1.2742615 2.6651955
##  [15] 3.4298095 3.4829668 1.6458373 3.4261839 0.7872355 1.3565655 1.8291144
##  [22] 2.5803463 1.9327863 1.1596651 2.8079523 2.6193329 3.0548744 2.6865889
##  [29] 4.7669574 3.7058385 4.2167978 1.2804495 1.1842289 2.4108545 4.5358370
##  [36] 3.7353002 2.7315491 3.2160985 3.0447519 2.4733701 2.0224306 2.5978175
##  [43] 2.8002092 3.0130467 0.1874866 1.9110856 3.2808640 3.9735284 2.5533736
##  [50] 0.8972748 4.2410178 5.7786193 5.4887057 5.0996417 5.7141196 3.9183321
##  [57] 5.5031240 4.5767172 5.1417021 5.4251553 5.9130512 4.9488139 5.0922448
##  [64] 6.3769618 5.0249764 5.1926323 5.7997824 4.3842804 6.6046809 6.5088456
##  [71] 7.0890641 5.3911888 5.7998923 5.9862331 3.9695878 5.6079268 5.1391242
##  [78] 5.3903258 4.4938278 7.4809635 5.9385035 5.3743162 4.7278303 5.0933592
##  [85] 6.0168544 5.6386184 5.1610177 6.9309519 5.1174751 4.2599692 5.4438956
##  [92] 4.9843279 5.6473757 5.8969115 5.0583082 5.5785377 6.0044899 5.9533927
##  [99] 7.0513535 5.1362541
```

## create a potentially confounding variable or a control variable
> in the code below, we multiply every value in dep_var by 0.5 and then we "add noise": 100 random normal values whose true population has a mean = 0 and sd = 1.


```r
confound <- dep_var * 0.5 + rnorm(n = 100, mean = 0, sd = 1)

# print confound by just excecuting/running the name of the object
confound
```

```
##   [1]  3.68982168 -0.64933653  3.34561381  1.57420536  2.87222567
##   [6]  1.10837829 -0.10606791  2.34409569  1.36113013  0.70625160
##  [11]  1.50868802  0.69690404  0.86158926  0.57933731  3.49968616
##  [16]  2.24460628  1.48874639 -0.17255960  0.89204645  2.61235921
##  [21]  0.23631574  0.24421024  1.26551443  1.60837825  2.18447802
##  [26]  1.18632543  0.83635839  2.42090442  2.41430054  0.27208707
##  [31]  1.23523715  1.26094847  1.80707758  0.30926416  1.35877459
##  [36]  1.79016026  2.31943654  0.70421872 -0.91039051  0.47494713
##  [41]  0.73209702  0.08420201  0.41944524  1.17433342  0.28766219
##  [46]  1.07075390  0.55073137  1.19151489  0.62516843  0.12917209
##  [51]  2.21459850  2.36283222  2.04306121  3.18768885  5.60313416
##  [56]  0.72390809  3.70840995  1.56301570  1.91939581  2.79165458
##  [61]  3.58793853  3.91048098  3.11332089  4.23661769  1.63950360
##  [66]  2.79186165  2.63487260  1.99091002  3.23382379  2.40399138
##  [71]  3.28888897  3.85145196  1.83961211  1.32385405  1.44680366
##  [76]  4.87354812  2.93526596  3.11275741  3.51815580  3.01962153
##  [81]  4.47852458  0.82881949  1.55427673  3.20208071  2.62017185
##  [86]  1.54473548  1.46381081  2.87498799  2.48067075  1.54676178
##  [91]  2.87053648  2.72928634  4.16956398  2.69505812  1.87925062
##  [96]  2.48955029  0.28005923  2.05392561  3.62747060  3.25869759
```

## subject gender


```r
gender <- c("Woman", "Man") %>% rep(times = sample_size) %>% factor()

# print gender by just excecuting/running the name of the object
gender
```

```
##   [1] Woman Man   Woman Man   Woman Man   Woman Man   Woman Man   Woman
##  [12] Man   Woman Man   Woman Man   Woman Man   Woman Man   Woman Man  
##  [23] Woman Man   Woman Man   Woman Man   Woman Man   Woman Man   Woman
##  [34] Man   Woman Man   Woman Man   Woman Man   Woman Man   Woman Man  
##  [45] Woman Man   Woman Man   Woman Man   Woman Man   Woman Man   Woman
##  [56] Man   Woman Man   Woman Man   Woman Man   Woman Man   Woman Man  
##  [67] Woman Man   Woman Man   Woman Man   Woman Man   Woman Man   Woman
##  [78] Man   Woman Man   Woman Man   Woman Man   Woman Man   Woman Man  
##  [89] Woman Man   Woman Man   Woman Man   Woman Man   Woman Man   Woman
## [100] Man  
## Levels: Man Woman
```

## subject age


```r
age <- seq(from = 18, to = 25, by = 1) %>% sample(size = 100, replace = TRUE)

# print gender by just excecuting/running the name of the object
age
```

```
##   [1] 22 18 21 21 21 19 25 24 25 22 19 24 18 23 25 23 25 22 20 23 22 23 18
##  [24] 25 24 24 23 20 18 19 24 23 23 24 23 20 24 20 25 25 25 18 22 23 25 23
##  [47] 24 21 23 25 19 18 21 25 18 20 25 22 23 22 19 19 25 23 22 19 24 23 22
##  [70] 22 18 22 18 18 19 24 20 23 19 24 23 25 18 24 21 18 25 19 19 20 20 24
##  [93] 20 25 19 21 18 24 23 22
```

## `data.frame()` and `tibble()`
> "The concept of a data frame comes from the world of statistical software used in empirical research; it generally refers to "tabular" data: a data structure representing cases (rows), each of which consists of a number of observations or measurements (columns). Alternatively, each row may be treated as a single observation of multiple "variables". In any case, each row and each column has the same data type, but the row ("record") datatype may be heterogenous (a tuple of different types), while the column datatype must be homogenous. Data frames usually contain some metadata in addition to data; for example, column and row names." **Source:** https://github.com/mobileink/data.frame/wiki/What-is-a-Data-Frame%3F

> "**Tibbles** are a modern take on data frames. They keep the features that have stood the test of time, and drop the features that used to be convenient but are now frustrating (i.e. converting character vectors to factors)." **Source:** https://cran.r-project.org/web/packages/tibble/vignettes/tibble.html

## put all our variable we made into a tibble


```r
example_data <- tibble(subj_num, condition, dep_var, confound, gender, age)

# print example_data by just excecuting/running the name of the object
example_data
```

```
## # A tibble: 100 x 6
##    subj_num condition   dep_var   confound gender   age
##       <dbl>    <fctr>     <dbl>      <dbl> <fctr> <dbl>
##  1        1   control 3.8961988  3.6898217  Woman    22
##  2        2   control 2.6461046 -0.6493365    Man    18
##  3        3   control 4.1539669  3.3456138  Woman    21
##  4        4   control 1.1631392  1.5742054    Man    21
##  5        5   control 2.2008941  2.8722257  Woman    21
##  6        6   control 3.4340587  1.1083783    Man    19
##  7        7   control 1.9553243 -0.1060679  Woman    25
##  8        8   control 0.2393393  2.3440957    Man    24
##  9        9   control 2.2226448  1.3611301  Woman    25
## 10       10   control 2.9746707  0.7062516    Man    22
## # ... with 90 more rows
```

# data wrangling examples

## create new variables in data.frame or tibble
> * `mutate()` adds new variables to your tibble.


```r
example_data <- example_data %>%
  mutate(dep_var_z = dep_var %>% scale() %>% parse_number(),
         confound_z = confound %>% scale() %>% parse_number())

# print example_data by just excecuting/running the name of the object
example_data
```

```
## # A tibble: 100 x 8
##    subj_num condition   dep_var   confound gender   age   dep_var_z
##       <dbl>    <fctr>     <dbl>      <dbl> <fctr> <dbl>       <dbl>
##  1        1   control 3.8961988  3.6898217  Woman    22 -0.05813106
##  2        2   control 2.6461046 -0.6493365    Man    18 -0.76758963
##  3        3   control 4.1539669  3.3456138  Woman    21  0.08815852
##  4        4   control 1.1631392  1.5742054    Man    21 -1.60920816
##  5        5   control 2.2008941  2.8722257  Woman    21 -1.02025726
##  6        6   control 3.4340587  1.1083783    Man    19 -0.32040670
##  7        7   control 1.9553243 -0.1060679  Woman    25 -1.15962401
##  8        8   control 0.2393393  2.3440957    Man    24 -2.13348682
##  9        9   control 2.2226448  1.3611301  Woman    25 -1.00791325
## 10       10   control 2.9746707  0.7062516    Man    22 -0.58112047
## # ... with 90 more rows, and 1 more variables: confound_z <dbl>
```

## select specific columns
> * `select()` selects your tibble's variables by name.


```r
example_data %>% 
  select(subj_num, condition, dep_var)
```

```
## # A tibble: 100 x 3
##    subj_num condition   dep_var
##       <dbl>    <fctr>     <dbl>
##  1        1   control 3.8961988
##  2        2   control 2.6461046
##  3        3   control 4.1539669
##  4        4   control 1.1631392
##  5        5   control 2.2008941
##  6        6   control 3.4340587
##  7        7   control 1.9553243
##  8        8   control 0.2393393
##  9        9   control 2.2226448
## 10       10   control 2.9746707
## # ... with 90 more rows
```

## filter specific rows
> * `filter()` returns rows that all meet some condition you give it.
> * Note, `==` means "exactly equal to". See ?Comparison.


```r
example_data %>% 
  filter(condition == "control")
```

```
## # A tibble: 50 x 8
##    subj_num condition   dep_var   confound gender   age   dep_var_z
##       <dbl>    <fctr>     <dbl>      <dbl> <fctr> <dbl>       <dbl>
##  1        1   control 3.8961988  3.6898217  Woman    22 -0.05813106
##  2        2   control 2.6461046 -0.6493365    Man    18 -0.76758963
##  3        3   control 4.1539669  3.3456138  Woman    21  0.08815852
##  4        4   control 1.1631392  1.5742054    Man    21 -1.60920816
##  5        5   control 2.2008941  2.8722257  Woman    21 -1.02025726
##  6        6   control 3.4340587  1.1083783    Man    19 -0.32040670
##  7        7   control 1.9553243 -0.1060679  Woman    25 -1.15962401
##  8        8   control 0.2393393  2.3440957    Man    24 -2.13348682
##  9        9   control 2.2226448  1.3611301  Woman    25 -1.00791325
## 10       10   control 2.9746707  0.7062516    Man    22 -0.58112047
## # ... with 40 more rows, and 1 more variables: confound_z <dbl>
```

## make your own table of summary data
> * `summarize()` let's you apply functions to your data to reduce it to single values. Typically, you create new summary values based on groups (e.g., condition, gender, id); for this, use `group_by()` first.


```r
example_data %>% 
  group_by(gender, condition) %>% 
  summarize(Mean = mean(confound),
            SD = sd(confound),
            n = length(confound))
```

```
## # A tibble: 4 x 5
## # Groups:   gender [?]
##   gender    condition      Mean        SD     n
##   <fctr>       <fctr>     <dbl>     <dbl> <int>
## 1    Man      control 0.9986265 0.8532729    25
## 2    Man manipulation 2.6147239 1.0255267    25
## 3  Woman      control 1.3910275 1.1568390    25
## 4  Woman manipulation 2.7260448 1.1564526    25
```


# plotting your data ggplot2
> "ggplot2 is a plotting system for R, based on the grammar of graphics, which tries to take the good parts of base and lattice graphics and none of the bad parts. It takes care of many of the fiddly details that make plotting a hassle (like drawing legends) as well as providing a powerful model of graphics that makes it easy to produce complex multi-layered graphics." **Source:**: http://ggplot2.org/

## make ggplots in layers
> * Aesthetic mappings describe how variables in the data are mapped to visual properties (aesthetics) of geoms. **Source:** http://ggplot2.tidyverse.org/reference/aes.html
> * Below, we map condition on our plot's x-axis and dep_var on its y-axis 


```r
example_data %>%
  ggplot(mapping = aes(x = condition, y = dep_var))
```

![](learn_r_for_psychology_research_a_crash_course_files/figure-html/unnamed-chunk-26-1.png)<!-- -->

## boxplot
> * next, we add—yes, add, with a `+`—a geom, a geometric element: `geom_boxplot()`


```r
example_data %>%
  ggplot(mapping = aes(x = condition, y = dep_var)) +
  geom_boxplot()
```

![](learn_r_for_psychology_research_a_crash_course_files/figure-html/unnamed-chunk-27-1.png)<!-- -->

## QQ-plots
> * Below, we plot the sample quantiles of dep_var against the theoretical quantiles
> * Useful for exploring the distriubtion of a variable (default theoretial quantiles are normal, see ?geom_qq)


```r
example_data %>%
  ggplot(mapping = aes(sample = dep_var)) +
  geom_qq()
```

![](learn_r_for_psychology_research_a_crash_course_files/figure-html/unnamed-chunk-28-1.png)<!-- -->

## means and 95% confidence intervals
> * add a new aesthetic, fill, which will fill the geoms with different colors, depending on the variable (e.g., levels of categorical variables are assigned their own fill color)
> * stat_summary() does what its name suggests: it applies statistical summaries to your raw data to make the geoms (bars and error bars in our case below)
> * the width argument sets the width of the error bars.


```r
example_data %>%
  ggplot(mapping = aes(x = condition, y = dep_var, fill = condition)) +
  stat_summary(geom = "bar", fun.data = mean_cl_normal) +
  stat_summary(geom = "errorbar", fun.data = mean_cl_normal, width = 0.1)
```

![](learn_r_for_psychology_research_a_crash_course_files/figure-html/unnamed-chunk-29-1.png)<!-- -->

## scatterplots
> * we add `geom_point()` and `geom_smooth()` below to add points to the scatterplot and fit a linear regression line with 95% confidence ribbons/bands around that line


```r
example_data %>%
  ggplot(mapping = aes(x = confound, y = dep_var)) +
  geom_point() +
  geom_smooth(method = "lm")
```

![](learn_r_for_psychology_research_a_crash_course_files/figure-html/unnamed-chunk-30-1.png)<!-- -->

# descriptive statistics
> * `describe()`
> * `describeBy()`

## for whole sample


```r
example_data %>% 
  select(dep_var, dep_var_z, confound, confound_z) %>% 
  describe()
```

```
##            vars   n mean   sd median trimmed  mad   min  max range  skew
## dep_var       1 100 4.00 1.76   4.23    4.05 2.10  0.19 7.48  7.29 -0.23
## dep_var_z     2 100 0.00 1.00   0.13    0.03 1.19 -2.16 1.98  4.14 -0.23
## confound      3 100 1.93 1.28   1.82    1.90 1.45 -0.91 5.60  6.51  0.25
## confound_z    4 100 0.00 1.00  -0.09   -0.03 1.13 -2.21 2.86  5.07  0.25
##            kurtosis   se
## dep_var       -0.98 0.18
## dep_var_z     -0.98 0.10
## confound      -0.39 0.13
## confound_z    -0.39 0.10
```

## by condition
> The code below is a little confusing. First, we're piping our subsetted tibble with only our four variables—dep_var and confound and their z-scored versions—into the first argument for the `describeBy()` function. But we need to give data to the group argument, so then we just give it another subsetted tibble with only our grouping variable, condition.


```r
example_data %>% 
  select(dep_var, dep_var_z, confound, confound_z) %>% 
  describeBy(group = example_data %>% select(condition))
```

```
## 
##  Descriptive statistics by group 
## condition: control
##            vars  n  mean   sd median trimmed  mad   min  max range  skew
## dep_var       1 50  2.52 1.08   2.61    2.52 1.09  0.19 4.77  4.58 -0.11
## dep_var_z     2 50 -0.84 0.62  -0.79   -0.84 0.62 -2.16 0.44  2.60 -0.11
## confound      3 50  1.19 1.03   1.14    1.14 0.97 -0.91 3.69  4.60  0.48
## confound_z    4 50 -0.57 0.80  -0.62   -0.62 0.76 -2.21 1.37  3.58  0.48
##            kurtosis   se
## dep_var       -0.61 0.15
## dep_var_z     -0.61 0.09
## confound      -0.18 0.15
## confound_z    -0.18 0.11
## -------------------------------------------------------- 
## condition: manipulation
##            vars  n mean   sd median trimmed  mad   min  max range skew
## dep_var       1 50 5.48 0.78   5.43    5.45 0.58  3.92 7.48  3.56 0.33
## dep_var_z     2 50 0.84 0.44   0.81    0.83 0.33 -0.05 1.98  2.02 0.33
## confound      3 50 2.67 1.08   2.71    2.64 1.12  0.28 5.60  5.32 0.23
## confound_z    4 50 0.57 0.84   0.61    0.55 0.87 -1.29 2.86  4.14 0.23
##            kurtosis   se
## dep_var        0.07 0.11
## dep_var_z      0.07 0.06
## confound      -0.05 0.15
## confound_z    -0.05 0.12
```

# read in your own data
> * .csv file: `read_csv()`
> * .txt file: `read_delim()`
> * SPSS .sav file: `read_sav()`

## SPSS


```r
# path to where file lives on your computer
coffee_filepath <- "coffee.sav"

coffee_data <- coffee_filepath %>% read_sav()

# print coffee_data by just excecuting/running the name of the object
coffee_data
```

```
## # A tibble: 138 x 3
##    image brand  freq
##    <dbl> <dbl> <dbl>
##  1     1     1    82
##  2     2     1    96
##  3     3     1    72
##  4     4     1   101
##  5     5     1    66
##  6     6     1     6
##  7     7     1    47
##  8     8     1     1
##  9     9     1    16
## 10    10     1    60
## # ... with 128 more rows
```

## CSV


```r
# path to where file lives on your computer
coffee_filepath <- "coffee.csv"

coffee_data <- coffee_filepath %>% read_csv()
```

```
## Parsed with column specification:
## cols(
##   image = col_integer(),
##   brand = col_integer(),
##   freq = col_integer()
## )
```

## TXT


```r
# path to where file lives on your computer
coffee_filepath <- "coffee.txt"

coffee_data <- coffee_filepath %>% read_delim(delim = " ")
```

```
## Parsed with column specification:
## cols(
##   image = col_integer(),
##   brand = col_integer(),
##   freq = col_integer()
## )
```

# modeling your data

## `t.test()`


```r
t.test(dep_var ~ condition, data = example_data)
```

```
## 
## 	Welch Two Sample t-test
## 
## data:  dep_var by condition
## t = -15.71, df = 88.882, p-value < 2.2e-16
## alternative hypothesis: true difference in means is not equal to 0
## 95 percent confidence interval:
##  -3.34177 -2.59134
## sample estimates:
##      mean in group control mean in group manipulation 
##                   2.515351                   5.481906
```

## `pairs.panels()`
> shows a scatter plot of matrices (SPLOM), with bivariate scatter plots below the diagonal, histograms on the diagonal, and the Pearson correlation above the diagonal (see ?pairs.panels).


```r
example_data %>% 
  select(dep_var, confound, age) %>% 
  pairs.panels()
```

![](learn_r_for_psychology_research_a_crash_course_files/figure-html/unnamed-chunk-37-1.png)<!-- -->

## `lm()`


```r
lm_fit <- lm(dep_var ~ condition + confound, data = example_data)

# print lm_fit by just excecuting/running the name of the object
lm_fit
```

```
## 
## Call:
## lm(formula = dep_var ~ condition + confound, data = example_data)
## 
## Coefficients:
##           (Intercept)  conditionmanipulation               confound  
##                2.2756                 2.6705                 0.2006
```

## `summary()`


```r
lm_fit %>% summary()
```

```
## 
## Call:
## lm(formula = dep_var ~ condition + confound, data = example_data)
## 
## Residuals:
##      Min       1Q   Median       3Q      Max 
## -2.50659 -0.49876 -0.04209  0.56321  2.00695 
## 
## Coefficients:
##                       Estimate Std. Error t value Pr(>|t|)    
## (Intercept)            2.27564    0.16826  13.525   <2e-16 ***
## conditionmanipulation  2.67052    0.22650  11.790   <2e-16 ***
## confound               0.20063    0.08858   2.265   0.0257 *  
## ---
## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
## 
## Residual standard error: 0.9249 on 97 degrees of freedom
## Multiple R-squared:  0.7301,	Adjusted R-squared:  0.7245 
## F-statistic: 131.2 on 2 and 97 DF,  p-value: < 2.2e-16
```

## `Anova()`


```r
lm_fit %>% Anova(type = "III")
```

```
## Anova Table (Type III tests)
## 
## Response: dep_var
##              Sum Sq Df  F value  Pr(>F)    
## (Intercept) 156.469  1 182.9173 < 2e-16 ***
## condition   118.915  1 139.0148 < 2e-16 ***
## confound      4.388  1   5.1295 0.02575 *  
## Residuals    82.975 97                     
## ---
## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
```

## recommended resources
> * ReadCollegePDX (2015, October 19). Hadley Wickham "Data Science with R". Retrieved from https://youtu.be/K-ss_ag2k9E?list=PLNtpLD4WiWbw9Cgcg6IU75u-44TrrN3A4
> * Robinson, D. (2017, July 05). Teach the tidyverse to beginners. Variance Explained. Retreived from http://varianceexplained.org/r/teach-tidyverse/
> * Wickham, H. (2014). [Tidy data](http://vita.had.co.nz/papers/tidy-data.html). Journal of Statistical Software, 59(10), 1-23.
> * [The tidyverse style guide](http://style.tidyverse.org/) by Hadley Wickham
> * Wickham, H., & Grolemund, G. (2017). [R for Data Science: Import, Tidy, Transform, Visualize, and Model Data](http://r4ds.had.co.nz/). Sebastopol, CA: O'Reilly Media, Inc.

## more advanced data wrangling and analysis techniques by psychologists, for psychologists
> * [R programming for research](https://github.com/nmmichalak/R_programming_for_research), a workshop instructed by Nick Michalak and Iris Wang at the University of Michigan

## more information about tidyverse and the psych package
> * [tidyverse: R packages for data science](https://www.tidyverse.org/)
> * [Using R and psych for personality and psychological research](http://personality-project.org/r/psych/)

## R Studio cheat sheets
> * [RStudio Cheat Sheets](https://www.rstudio.com/resources/cheatsheets/)












