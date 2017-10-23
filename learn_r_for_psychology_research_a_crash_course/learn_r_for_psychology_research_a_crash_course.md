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
> This is the hardest section of the tutorial. Keep this is mind: we're making variables that you might see in a simple psychology dataset, and then we're going to combine them into a dataset. Don't worry about specifcs too much. If you want to understand how a function works, use ?name_of_function or help(name_of_function).

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
##  [1] -0.44628137 -1.87705082 -0.33047983  0.43795881 -1.43258544
##  [6] -0.67463496  0.14795293  0.79855700 -0.34602751 -0.06775113
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
##   [1] 1.746558533 2.889935065 4.119708833 3.320479732 2.444418185
##   [6] 3.200217553 2.018105160 4.338430979 1.554626581 1.689718323
##  [11] 3.729489187 3.414239824 2.390056502 0.003209212 2.209718729
##  [16] 2.419923647 1.986636573 2.575757371 1.994697159 3.026472514
##  [21] 2.403084995 3.702714759 2.625729779 1.948701350 1.776828507
##  [26] 3.008844272 3.008566458 1.643795357 1.647406586 2.371784394
##  [31] 3.483015882 3.383803353 3.084551355 2.566365839 2.364782354
##  [36] 4.119746857 2.426640939 3.320116287 2.338332504 3.274929468
##  [41] 2.812393539 1.674138101 4.413968458 1.484892983 3.824680709
##  [46] 3.860702917 1.669001299 1.376886558 1.933020185 0.590912954
##  [51] 6.727153909 5.943160822 6.472075899 4.745664095 4.793174142
##  [56] 5.683386548 4.727160528 5.113839477 5.883266405 6.106125472
##  [61] 5.018871787 5.023196105 4.711724383 6.729362063 4.144558242
##  [66] 3.741025011 6.901049246 6.494088749 6.618155968 4.053721458
##  [71] 5.885687678 4.436469868 6.372348095 6.142817310 4.376314325
##  [76] 3.886707007 6.465025287 5.902290357 6.657515614 5.612434940
##  [81] 6.145724089 6.730771992 4.974189403 4.221758821 5.064155116
##  [86] 3.833987125 4.618152690 5.578304441 5.309482305 5.488169562
##  [91] 5.849774073 5.732240647 5.495852027 5.891064179 5.035678064
##  [96] 3.945655183 5.129738086 7.108418406 4.834176508 5.229839881
```

## create a potentially confounding variable or a control variable
> in the code below, we multiply every value in dep_var by 0.5 and then we "add noise": 100 random normal values whose true population has a mean = 0 and sd = 1.


```r
confound <- dep_var * 0.5 + rnorm(n = 100, mean = 0, sd = 1)

# print confound by just excecuting/running the name of the object
confound
```

```
##   [1] -0.25927134  1.18503705  1.19165944 -0.16578106  3.10716786
##   [6] -0.11398636  1.38621160  2.83367727  2.13795528  0.21473335
##  [11]  1.52826781  2.61309458  2.72116688 -0.91140015  1.08877456
##  [16]  0.83499997 -0.40145345 -0.03801224  0.36544620  1.45536498
##  [21]  2.79726168  0.61975268  2.17769026  0.07277425  1.57171857
##  [26]  1.52627160 -0.22138744  0.27423398  1.41109207  2.15853407
##  [31]  0.80918848  1.80411288  2.11102652  0.74390091  3.69594416
##  [36]  3.31827867  1.93819657  1.34283557  1.61424148  1.55567751
##  [41]  0.35432104  0.80298929  4.00799207  0.24565545  2.10948771
##  [46]  2.16869930  0.02154671  0.54137037  1.01151284 -1.18472267
##  [51]  4.25901585  2.02588109  2.03373659  1.99652428  3.16384754
##  [56]  2.50677357  3.03303215  2.74900100  3.15941478  3.68226062
##  [61]  1.93210304  2.25681678  3.22161887  2.43439002  2.47390496
##  [66]  1.20365007  3.27557989  3.46778406  2.97684889  0.96296791
##  [71]  4.20759535  3.90870061  2.76843219  2.72704833  3.70042629
##  [76]  1.32589811  2.76506270  3.91940876  2.73026787  3.28697718
##  [81]  3.21273952  3.57608787  1.84786714  0.60563548  3.47467709
##  [86]  1.74468537  3.12446193  1.97511070  1.56778626  2.59796990
##  [91]  2.80521943  2.35874795  0.95430293  2.92324730  3.57018928
##  [96]  0.43261613  3.08063759  3.33284812  1.29304613  0.79496400
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
##   [1] 20 21 21 19 23 23 24 19 25 23 18 23 19 20 22 19 18 23 20 21 23 20 19
##  [24] 24 25 20 22 19 19 19 25 24 25 24 25 18 24 23 18 24 20 22 20 22 24 23
##  [47] 23 25 24 18 19 25 19 23 20 23 21 19 20 24 22 21 20 19 25 21 24 19 20
##  [70] 19 24 19 20 22 25 18 25 23 18 20 23 19 24 23 24 21 23 19 20 22 21 21
##  [93] 23 23 20 25 19 21 19 20
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
##    subj_num condition  dep_var   confound gender   age
##       <dbl>    <fctr>    <dbl>      <dbl> <fctr> <dbl>
##  1        1   control 1.746559 -0.2592713  Woman    20
##  2        2   control 2.889935  1.1850371    Man    21
##  3        3   control 4.119709  1.1916594  Woman    21
##  4        4   control 3.320480 -0.1657811    Man    19
##  5        5   control 2.444418  3.1071679  Woman    23
##  6        6   control 3.200218 -0.1139864    Man    23
##  7        7   control 2.018105  1.3862116  Woman    24
##  8        8   control 4.338431  2.8336773    Man    19
##  9        9   control 1.554627  2.1379553  Woman    25
## 10       10   control 1.689718  0.2147334    Man    23
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
##    subj_num condition  dep_var   confound gender   age   dep_var_z
##       <dbl>    <fctr>    <dbl>      <dbl> <fctr> <dbl>       <dbl>
##  1        1   control 1.746559 -0.2592713  Woman    20 -1.32582992
##  2        2   control 2.889935  1.1850371    Man    21 -0.65548995
##  3        3   control 4.119709  1.1916594  Woman    21  0.06550308
##  4        4   control 3.320480 -0.1657811    Man    19 -0.40306978
##  5        5   control 2.444418  3.1071679  Woman    23 -0.91668805
##  6        6   control 3.200218 -0.1139864    Man    23 -0.47357722
##  7        7   control 2.018105  1.3862116  Woman    24 -1.16662728
##  8        8   control 4.338431  2.8336773    Man    19  0.19373572
##  9        9   control 1.554627  2.1379553  Woman    25 -1.43835598
## 10       10   control 1.689718  0.2147334    Man    23 -1.35915426
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
##    subj_num condition  dep_var
##       <dbl>    <fctr>    <dbl>
##  1        1   control 1.746559
##  2        2   control 2.889935
##  3        3   control 4.119709
##  4        4   control 3.320480
##  5        5   control 2.444418
##  6        6   control 3.200218
##  7        7   control 2.018105
##  8        8   control 4.338431
##  9        9   control 1.554627
## 10       10   control 1.689718
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
##    subj_num condition  dep_var   confound gender   age   dep_var_z
##       <dbl>    <fctr>    <dbl>      <dbl> <fctr> <dbl>       <dbl>
##  1        1   control 1.746559 -0.2592713  Woman    20 -1.32582992
##  2        2   control 2.889935  1.1850371    Man    21 -0.65548995
##  3        3   control 4.119709  1.1916594  Woman    21  0.06550308
##  4        4   control 3.320480 -0.1657811    Man    19 -0.40306978
##  5        5   control 2.444418  3.1071679  Woman    23 -0.91668805
##  6        6   control 3.200218 -0.1139864    Man    23 -0.47357722
##  7        7   control 2.018105  1.3862116  Woman    24 -1.16662728
##  8        8   control 4.338431  2.8336773    Man    19  0.19373572
##  9        9   control 1.554627  2.1379553  Woman    25 -1.43835598
## 10       10   control 1.689718  0.2147334    Man    23 -1.35915426
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
## 1    Man      control 0.9559236 1.1319689    25
## 2    Man manipulation 2.3518398 1.0439711    25
## 3  Woman      control 1.5310303 1.1924688    25
## 4  Woman manipulation 2.8252726 0.8320398    25
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
## dep_var       1 100 4.01 1.71   4.00    4.01 2.26  0.00 7.11  7.11 -0.04
## dep_var_z     2 100 0.00 1.00   0.00    0.00 1.33 -2.35 1.82  4.17 -0.04
## confound      3 100 1.92 1.27   2.01    1.95 1.50 -1.18 4.26  5.44 -0.24
## confound_z    4 100 0.00 1.00   0.07    0.03 1.18 -2.44 1.84  4.28 -0.24
##            kurtosis   se
## dep_var       -1.05 0.17
## dep_var_z     -1.05 0.10
## confound      -0.81 0.13
## confound_z    -0.81 0.10
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
## dep_var       1 50  2.58 0.95   2.44    2.58 1.06  0.00 4.41  4.41 -0.15
## dep_var_z     2 50 -0.83 0.56  -0.92   -0.84 0.62 -2.35 0.24  2.59 -0.15
## confound      3 50  1.24 1.19   1.27    1.20 1.33 -1.18 4.01  5.19  0.22
## confound_z    4 50 -0.53 0.93  -0.51   -0.56 1.05 -2.44 1.65  4.09  0.22
##            kurtosis   se
## dep_var       -0.22 0.13
## dep_var_z     -0.22 0.08
## confound      -0.56 0.17
## confound_z    -0.56 0.13
## -------------------------------------------------------- 
## condition: manipulation
##            vars  n mean   sd median trimmed  mad   min  max range  skew
## dep_var       1 50 5.43 0.92   5.49    5.45 1.01  3.74 7.11  3.37 -0.08
## dep_var_z     2 50 0.83 0.54   0.87    0.84 0.59 -0.16 1.82  1.97 -0.08
## confound      3 50 2.59 0.96   2.76    2.64 1.06  0.43 4.26  3.83 -0.45
## confound_z    4 50 0.53 0.76   0.66    0.57 0.83 -1.17 1.84  3.01 -0.45
##            kurtosis   se
## dep_var       -1.07 0.13
## dep_var_z     -1.07 0.08
## confound      -0.65 0.14
## confound_z    -0.65 0.11
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
## t = -15.259, df = 97.883, p-value < 2.2e-16
## alternative hypothesis: true difference in means is not equal to 0
## 95 percent confidence interval:
##  -3.217790 -2.477121
## sample estimates:
##      mean in group control mean in group manipulation 
##                   2.584255                   5.431710
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
##                2.0501                 2.2697                 0.4295
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
## -1.65545 -0.63828 -0.01497  0.64276  1.55771 
## 
## Coefficients:
##                       Estimate Std. Error t value Pr(>|t|)    
## (Intercept)            2.05014    0.14887  13.772  < 2e-16 ***
## conditionmanipulation  2.26969    0.19213  11.814  < 2e-16 ***
## confound               0.42954    0.07599   5.653 1.59e-07 ***
## ---
## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
## 
## Residual standard error: 0.8134 on 97 degrees of freedom
## Multiple R-squared:  0.7772,	Adjusted R-squared:  0.7726 
## F-statistic: 169.2 on 2 and 97 DF,  p-value: < 2.2e-16
```

## `Anova()`


```r
lm_fit %>% Anova(type = "III")
```

```
## Anova Table (Type III tests)
## 
## Response: dep_var
##              Sum Sq Df F value    Pr(>F)    
## (Intercept) 125.487  1 189.662 < 2.2e-16 ***
## condition    92.339  1 139.561 < 2.2e-16 ***
## confound     21.142  1  31.954 1.586e-07 ***
## Residuals    64.179 97                      
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












