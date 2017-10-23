# learn R for psychology research: a crash course
Nicholas Michalak  
October 23, 2017  

# introduction
> I wrote this for psychologists who want to learn how to use R in their research **right now.** What does a psychologist need to know to use R to import, wrangle, plot, and model their data today? Here we go.

# foundations: people and their resources that inspired me.
> * [Dan Robinson (July 05, 2017)](http://varianceexplained.org/r/teach-tidyverse/) convinced me that beginneRs should learn tidyverse first, not Base R. This tutorial uses tidyverse. All you need to know about the differnece is in his blog post. If you've learned some R before this, you might understand that difference as you go through this tutorial.
> * If you want a more detailed introduction to R, start with [R for Data Science (Wickham & Grolemund, 2017)](http://r4ds.had.co.nz/). The chapters are short, easy to read, and filled with simple coding examples that demonstrate big principles. And **it's free.**
> * Hadley Wickham is a legend in the R community. He's responsible for the tidyverse, including ggplot2. Read his books and papers (e.g., [Wickham, 2014](http://vita.had.co.nz/papers/tidy-data.html)). Watch his talks (e.g., [ReadCollegePDX, October 19, 2015](https://youtu.be/K-ss_ag2k9E?list=PLNtpLD4WiWbw9Cgcg6IU75u-44TrrN3A4)). He's profoundly changed how people think about structuring and visualizing data.

# need-to-know basics

## Install R and R Studio (you need both in that order)
> * Installing R ( [Macintosh](https://stats.idre.ucla.edu/r/icu/installing-r-for-macintosh/) / [Windows](https://stats.idre.ucla.edu/r/icu/installing-r-for-windows/))
> * Uninstalling R ( [Macintosh](https://cran.r-project.org/doc/manuals/r-release/R-admin.html#Uninstalling-under-macOS) / [Windows](https://cran.r-project.org/doc/manuals/r-release/R-admin.html#Uninstallation))
> * [Installing R Studio](https://www.rstudio.com/products/rstudio/download/)
> * [Uninstalling R Studio](https://support.rstudio.com/hc/en-us/articles/200554736-How-To-Uninstall-RStudio-Desktop)

## understand all the panels in R Studio
![Four panels in R Studio](r_studio_panels_tutorial.png)

## packages: they're like apps you download for R
> "Packages are collections of R functions, data, and compiled code in a well-defined format. The directory where packages are stored is called the library. R comes with a standard set of packages. Others are available for download and installation. Once installed, they have to be loaded into the session to be used." **Source:** https://www.statmethods.net/interface/packages.html


```r
# before you can load these libraries, you need to install them first (remove the # part first):
# install.packages(tidyverse)
# install.packages(haven)
# install.packages(psych)
# install.packages(car)

library(tidyverse)
library(haven)
library(psych)
library(car)
```

## objects: they save stuff for you
> "`object <- fuction(x)`, which means 'object is created from function(x)'. An object is anything created in R. It could be a variable, a collection of variables, a statistical model, etc. Objects can be single values (such as the mean of a set of scores) or collections of information; for example, when you run an analysis, you create an object that contains the output of that analysis, which means that this object contains many different values and variables. Functions are the things that you do in R to create your objects." **Source:** Field, A., Miles., J., & Field, Z. (2012). Discovering statistics using R. London: SAGE Publications.

## `c()` function: combine things like thing1, thing2, thing3, ...
> "c" stands for combine. Use this to combine values into a vector. "A vector is a sequence of data 'elements' of the same basic type." **Source:** http://www.r-tutor.com/r-introduction/vector
> Below, we create an object called five_numbers. We are naming it for what it is, but we could name it whatever we want: some_numbers, maple_tree, platypus. It doesn't matter. We'll use this in the examples in later chunks of code.


```r
# read: combine 1, 2, 3, 4, 5 and "save to", <-, five_numbers
five_numbers <- c(1, 2, 3, 4, 5)

# print five_numbers by just excecuting/running the name of the object
five_numbers
```

```
## [1] 1 2 3 4 5
```

## R Help: `help()` and `?`
> "The help() function and ? help operator in R provide access to the documentation pages for R functions, data sets, and other objects, both for packages in the standard R distribution and for contributed packages. To access documentation for the standard lm (linear model) function, for example, enter the command help(lm) or help("lm"), or ?lm or ?"lm" (i.e., the quotes are optional)." **Source:** https://www.r-project.org/help.html

## piping, `%>%`: write code kinda like you write sentences
> The `%>%` operator allows you to "pipe" a value forward into an expression or function; something along the lines of x `%>%` f, rather than f(x). See http://magrittr.tidyverse.org/articles/magrittr.html for more details, but check out these examples below.

## compute z-scores for those five numbers, called five_numbers
> * see help(scale) for details


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
> * see help(parse_number) for details


```r
five_numbers %>% scale() %>% parse_number()
```

```
## [1] -1.2649111 -0.6324555  0.0000000  0.6324555  1.2649111
```

## compute z-scores for five_numbers and then convert the result into only numbers and then compute the mean
> * see help(mean) for details


```r
five_numbers %>% scale() %>% parse_number() %>% mean()
```

```
## [1] 0
```

## tangent: most R introductions will teach you to code the example above like this:


```r
mean(parse_number(scale(five_numbers)))
```

```
## [1] 0
```

> * I think this code is counterintuitive. You're reading the current sentence from left to right. That's how I think code should read like: how you read sentences. Forget this "read from the inside out" way of coding for now. You can learn the "read R code inside out" way when you have time and feel motivated to learn harder things. I'm assuming you don't right now.

## functions: they do things for you
> "A function is a piece of code written to carry out a specified task; it can or can not accept arguments or parameters and it can or can not return one or more values." Functions **do** things for you. **Source:** https://www.datacamp.com/community/tutorials/functions-in-r-a-tutorial#what

## compute the num of five_numbers
> * see help(sum) for details


```r
five_numbers %>% sum()
```

```
## [1] 15
```

## compute the length of five_numbers
> * see help(length) for details


```r
five_numbers %>% length()
```

```
## [1] 5
```

## compute the sum of five_numbers and divide by the length of five_numbers
> * see help(Arithmetic) for details


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

## tangent: functions make assumptions; know what they are

### what is the mean of 5 numbers and a unknown number, NA?
> * see help(NA) for details


```r
c(1, 2, 3, 4, 5, NA) %>% mean()
```

```
## [1] NA
```

> Is this what you expected? Turns out, this isn’t a quirky feature of R. R was designed by statisticians and mathematicians. `NA` represents a value that is unknown. Ask yourself, what is the sum of an unknown value and 17? If you don’t know the value, then you don’t know the value of adding it to 17 either. The `mean()` function gives `NA` for this reason: the mean of 5 values and an unknwon value is `NA`; it’s unknown; it’s not available; it's missing. When you use functions in your own research, think about what the functions “assume” or “know”; ask, "What do I want the function to do? What do I expect it to do? Can the function do what I want with the information I gave it?"

### tell the `mean()` function to remove missing values


```r
c(1, 2, 3, 4, 5, NA) %>% mean(na.rm = TRUE)
```

```
## [1] 3
```

# create data for psychology-like examples
> This is the hardest section of the tutorial. Keep this is mind: we're making variables that you might see in a simple psychology dataset, and then we're going to combine them into a dataset. Don't worry about specifcs too much. If you want to understand how a function works, use ?name_of_function or help(name_of_function).

## subject numbers
> * read like this: generate a sequence of values from 1 to 100 by 1
> * see help(seq) for details


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

> See those numbers on the left hand side of the output above? Those help you keep track of a sequence (i.e., line) of elements as the output moves to each new line. This is obvious in the example above because numbers correspond exactly to their position. But if these were letters or random numbers, that index or position (e.g., [14] "N") tells you the position of that element in the line.

## condition assignments
> * read like this: replicate each element of c("control", "manipulation") 50 times, and then turn the result into a factor
> * side: in R, factors are nominal variables (i.e., integers) with value labels (i.e., names for each integer).
> * see help(rep) and help(factor) for details


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
> * see help(rnorm) for details


```r
# for example
rnorm(n = 10, mean = 0, sd = 1)
```

```
##  [1]  0.4988412  0.4513771 -0.2973467  0.2223318 -0.5017280  1.0026637
##  [7] -0.1939937 -0.3201888 -0.6309499 -2.0529953
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
##   [1] 2.2777487 1.2665260 1.1137860 3.2686107 1.2685932 2.5667477 1.7086125
##   [8] 2.6985898 2.4107095 2.4023654 1.2494315 4.0752940 3.0508002 1.5794739
##  [15] 1.4157455 2.4935414 2.8769779 1.3136503 1.2818850 3.8694775 2.4500834
##  [22] 1.8195915 2.8829183 1.5320780 2.7603081 1.7426663 1.7397207 3.7384477
##  [29] 2.8774464 1.7515823 0.2966049 1.9588521 2.3403697 2.2818818 2.6958423
##  [36] 4.0386243 1.9103397 3.0622793 2.2137609 1.8843253 2.7077436 3.0492736
##  [43] 3.4255306 2.5052827 1.9399870 1.9821767 2.5268302 2.3780100 2.5265585
##  [50] 3.3985445 5.0102130 4.5952889 6.0958715 6.8031089 7.0136284 7.2428511
##  [57] 5.5631437 5.0748988 3.8733280 4.7973715 5.9256951 6.2659642 4.3562385
##  [64] 7.2046872 6.7696040 5.5905217 4.8117649 4.9542723 5.0518969 6.4896912
##  [71] 7.1684560 5.2236049 3.8135066 7.1790643 4.4569422 5.9529518 6.6049534
##  [78] 5.6211843 4.9887855 3.1696233 2.8162593 5.8356004 5.1894867 6.8699944
##  [85] 5.7032343 6.0447437 4.9839360 7.3780506 7.5643073 5.8124738 4.7206584
##  [92] 6.1879241 3.5006453 5.1805861 4.1438303 5.6985843 5.5520025 5.2853474
##  [99] 6.0288552 5.5370811
```

## create a potentially confounding variable or a control variable
> in the code below, we multiply every value in dep_var by 0.5 and then we "add noise": 100 random normal values whose true population has a mean = 0 and sd = 1. Every value in dep_var * 0.5 gets a random value added to it.


```r
confound <- dep_var * 0.5 + rnorm(n = 100, mean = 0, sd = 1)

# print confound by just excecuting/running the name of the object
confound
```

```
##   [1] -1.271319819  1.176223642  1.878694578  0.128643300  0.844233967
##   [6]  1.381392137  1.880538341  1.337890015  1.110715636  1.361817109
##  [11]  1.603087837  3.123745340  2.183443513  0.403730328  1.087338861
##  [16]  2.195237890  3.350755892 -0.050401746  0.120594521  1.165796164
##  [21]  1.561490122  0.539031081  1.465938855 -0.838677511  1.031425095
##  [26]  1.473735157 -0.274766382  2.304486621  3.308368685 -1.062316950
##  [31]  2.087087923  2.084303433  2.221398905  1.161210307  3.410519960
##  [36]  1.938431895 -0.001852285  1.641600158  1.620767367  0.831961946
##  [41]  1.533141665 -0.216133487  3.625159026  0.426116199 -0.315001755
##  [46]  0.259659565  1.058037597  2.559575585  1.199372907  1.816135958
##  [51]  1.734148699  0.638977568  2.521768846  0.838728283  2.866508821
##  [56]  1.318572925  4.372704060  4.379133427  1.315012321  2.733563980
##  [61]  2.427223428  3.861432227  3.933279995  3.394845425  1.994232386
##  [66]  2.782069321  3.125970030  2.767182897  1.802731454  3.134101235
##  [71]  3.974707728  3.955428857  0.775965404  4.194199445  2.363637036
##  [76]  2.461388167  2.378623434  3.546992533  2.869796640 -0.965451091
##  [81]  1.679075029  4.159692621  1.428324149  4.461568580  3.742971668
##  [86]  2.700182919  2.655973768  2.872534643  3.695444098  1.988741360
##  [91]  1.925195083  3.490138432  1.418964877  2.656124775  1.146638194
##  [96]  2.118632482  3.492533424  3.755827966  2.442457592  3.947278043
```

## subject gender
> * read like this: replicate each element of c("Woman", "Man") sample_size = 50 times, and then turn the result into a factor


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
> * read like this: generate a sequence of values from 18 to 25 by 1, and take a random sample of 100 values from that sequence (with replacement)
> * see help(sample) for details


```r
age <- seq(from = 18, to = 25, by = 1) %>% sample(size = 100, replace = TRUE)

# print gender by just excecuting/running the name of the object
age
```

```
##   [1] 23 22 20 23 22 22 24 23 25 25 20 21 20 20 25 23 24 21 22 22 20 22 18
##  [24] 21 20 21 18 25 25 21 23 23 25 19 18 20 18 19 21 21 22 19 24 25 20 24
##  [47] 25 23 24 18 21 25 21 21 18 20 23 19 24 22 20 21 22 19 23 19 20 21 19
##  [70] 20 23 19 21 23 22 20 25 22 24 21 23 24 19 24 25 25 18 20 21 25 19 25
##  [93] 18 24 23 18 19 24 19 20
```

## `data.frame()` and `tibble()`
> "The concept of a data frame comes from the world of statistical software used in empirical research; it generally refers to "tabular" data: a data structure representing cases (rows), each of which consists of a number of observations or measurements (columns). Alternatively, each row may be treated as a single observation of multiple "variables". In any case, each row and each column has the same data type, but the row ("record") datatype may be heterogenous (a tuple of different types), while the column datatype must be homogenous. Data frames usually contain some metadata in addition to data; for example, column and row names." **Source:** https://github.com/mobileink/data.frame/wiki/What-is-a-Data-Frame%3F

> "**Tibbles** are a modern take on data frames. They keep the features that have stood the test of time, and drop the features that used to be convenient but are now frustrating (i.e. converting character vectors to factors)." **Source:** https://cran.r-project.org/web/packages/tibble/vignettes/tibble.html

## put all our variable we made into a tibble
> * every variable we made above is seperated by a comma -- these will become columns in our dataset
> * see help(data.frame) and help(tibble) for details


```r
example_data <- tibble(subj_num, condition, dep_var, confound, gender, age)

# print example_data by just excecuting/running the name of the object
example_data
```

```
## # A tibble: 100 x 6
##    subj_num condition  dep_var   confound gender   age
##       <dbl>    <fctr>    <dbl>      <dbl> <fctr> <dbl>
##  1        1   control 2.277749 -1.2713198  Woman    23
##  2        2   control 1.266526  1.1762236    Man    22
##  3        3   control 1.113786  1.8786946  Woman    20
##  4        4   control 3.268611  0.1286433    Man    23
##  5        5   control 1.268593  0.8442340  Woman    22
##  6        6   control 2.566748  1.3813921    Man    22
##  7        7   control 1.708612  1.8805383  Woman    24
##  8        8   control 2.698590  1.3378900    Man    23
##  9        9   control 2.410710  1.1107156  Woman    25
## 10       10   control 2.402365  1.3618171    Man    25
## # ... with 90 more rows
```

# data wrangling examples

## create new variables in data.frame or tibble
> * `mutate()` adds new variables to your tibble.
> * we're adding new columns to our dataset, and we're saving this new dataset as the same name as our old one (i.e., like changing an Excel file and saving with the same name)
> * see help(mutate) for details


```r
example_data <- example_data %>%
  mutate(dep_var_z = dep_var %>% scale() %>% parse_number(),
         confound_z = confound %>% scale() %>% parse_number())

# print example_data by just excecuting/running the name of the object
example_data
```

```
## # A tibble: 100 x 8
##    subj_num condition  dep_var   confound gender   age  dep_var_z
##       <dbl>    <fctr>    <dbl>      <dbl> <fctr> <dbl>      <dbl>
##  1        1   control 2.277749 -1.2713198  Woman    23 -0.8805242
##  2        2   control 1.266526  1.1762236    Man    22 -1.4151932
##  3        3   control 1.113786  1.8786946  Woman    20 -1.4959522
##  4        4   control 3.268611  0.1286433    Man    23 -0.3566206
##  5        5   control 1.268593  0.8442340  Woman    22 -1.4141002
##  6        6   control 2.566748  1.3813921    Man    22 -0.7277203
##  7        7   control 1.708612  1.8805383  Woman    24 -1.1814465
##  8        8   control 2.698590  1.3378900    Man    23 -0.6580107
##  9        9   control 2.410710  1.1107156  Woman    25 -0.8102231
## 10       10   control 2.402365  1.3618171    Man    25 -0.8146350
## # ... with 90 more rows, and 1 more variables: confound_z <dbl>
```

## select specific columns
> * `select()` selects your tibble's variables by name and in the exact order you specify.
> * see help(select) for details


```r
example_data %>% 
  select(subj_num, condition, dep_var)
```

```
## # A tibble: 100 x 3
##    subj_num condition  dep_var
##       <dbl>    <fctr>    <dbl>
##  1        1   control 2.277749
##  2        2   control 1.266526
##  3        3   control 1.113786
##  4        4   control 3.268611
##  5        5   control 1.268593
##  6        6   control 2.566748
##  7        7   control 1.708612
##  8        8   control 2.698590
##  9        9   control 2.410710
## 10       10   control 2.402365
## # ... with 90 more rows
```

## filter specific rows
> * `filter()` returns rows that all meet some condition you give it.
> * Note, `==` means "exactly equal to". See ?Comparison.
> * see help(filter) for details


```r
example_data %>% 
  filter(condition == "control")
```

```
## # A tibble: 50 x 8
##    subj_num condition  dep_var   confound gender   age  dep_var_z
##       <dbl>    <fctr>    <dbl>      <dbl> <fctr> <dbl>      <dbl>
##  1        1   control 2.277749 -1.2713198  Woman    23 -0.8805242
##  2        2   control 1.266526  1.1762236    Man    22 -1.4151932
##  3        3   control 1.113786  1.8786946  Woman    20 -1.4959522
##  4        4   control 3.268611  0.1286433    Man    23 -0.3566206
##  5        5   control 1.268593  0.8442340  Woman    22 -1.4141002
##  6        6   control 2.566748  1.3813921    Man    22 -0.7277203
##  7        7   control 1.708612  1.8805383  Woman    24 -1.1814465
##  8        8   control 2.698590  1.3378900    Man    23 -0.6580107
##  9        9   control 2.410710  1.1107156  Woman    25 -0.8102231
## 10       10   control 2.402365  1.3618171    Man    25 -0.8146350
## # ... with 40 more rows, and 1 more variables: confound_z <dbl>
```

## make your own table of summary data
> * `summarize()` let's you apply functions to your data to reduce it to single values. Typically, you create new summary values based on groups (e.g., condition, gender, id); for this, use `group_by()` first.
> * see help(summarize) and help(group_by) for details


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
##   gender    condition     Mean        SD     n
##   <fctr>       <fctr>    <dbl>     <dbl> <int>
## 1    Man      control 1.085728 1.0442681    25
## 2    Man manipulation 2.847675 1.3126011    25
## 3  Woman      control 1.452767 1.2247015    25
## 4  Woman manipulation 2.483356 0.9848017    25
```


# plotting your data with ggplot2
> "ggplot2 is a plotting system for R, based on the grammar of graphics, which tries to take the good parts of base and lattice graphics and none of the bad parts. It takes care of many of the fiddly details that make plotting a hassle (like drawing legends) as well as providing a powerful model of graphics that makes it easy to produce complex multi-layered graphics." **Source:**: http://ggplot2.org/

## make ggplots in layers
> * Aesthetic mappings describe how variables in the data are mapped to visual properties (aesthetics) of geoms. **Source:** http://ggplot2.tidyverse.org/reference/aes.html
> * Below, we map condition on our plot's x-axis and dep_var on its y-axis
> * see help(ggplot) for details


```r
example_data %>%
  ggplot(mapping = aes(x = condition, y = dep_var))
```

![](learn_r_for_psychology_research_a_crash_course_files/figure-html/unnamed-chunk-28-1.png)<!-- -->

> * Think of this like a blank canvas that we're going to add pictures to or like a map of the ocean we're going to add land mass to

## boxplot
> * next, we add—yes, add, with a `+`—a geom, a geometric element: `geom_boxplot()`
> * see help(geom_boxplot) for details


```r
example_data %>%
  ggplot(mapping = aes(x = condition, y = dep_var)) +
  geom_boxplot()
```

![](learn_r_for_psychology_research_a_crash_course_files/figure-html/unnamed-chunk-29-1.png)<!-- -->

> * Here's emphasis: we started with a blank canvas, and we added a boxplot. All ggplots work this way: start with a base and add layers.

## QQ-plots
> * Below, we plot the sample quantiles of dep_var against the theoretical quantiles
> * Useful for exploring the distribution of a variable
> * see help(geom_qq) for details


```r
example_data %>%
  ggplot(mapping = aes(sample = dep_var)) +
  geom_qq()
```

![](learn_r_for_psychology_research_a_crash_course_files/figure-html/unnamed-chunk-30-1.png)<!-- -->

## means and 95% confidence intervals
> * add a new aesthetic, fill, which will fill the geoms with different colors, depending on the variable (e.g., levels of categorical variables are assigned their own fill color)
> * `stat_summary()` does what its name suggests: it applies statistical summaries to your raw data to make the geoms (bars and error bars in our case below)
> * the width argument sets the width of the error bars.
> * see help(stat_summary) for details


```r
example_data %>%
  ggplot(mapping = aes(x = condition, y = dep_var, fill = condition)) +
  stat_summary(geom = "bar", fun.data = mean_cl_normal) +
  stat_summary(geom = "errorbar", fun.data = mean_cl_normal, width = 0.1)
```

![](learn_r_for_psychology_research_a_crash_course_files/figure-html/unnamed-chunk-31-1.png)<!-- -->

## scatterplots
> * we add `geom_point()` and `geom_smooth()` below to add points to the scatterplot and fit a linear regression line with 95% confidence ribbons/bands around that line
> * see help(geom_point) and help(geom_smooth)for details


```r
example_data %>%
  ggplot(mapping = aes(x = confound, y = dep_var)) +
  geom_point() +
  geom_smooth(method = "lm", se = TRUE)
```

![](learn_r_for_psychology_research_a_crash_course_files/figure-html/unnamed-chunk-32-1.png)<!-- -->

# descriptive statistics
> * `describe()`, help(describe)
> * `describeBy()`, help(describeBy)

## for whole sample


```r
example_data %>% 
  select(dep_var, dep_var_z, confound, confound_z) %>% 
  describe()
```

```
##            vars   n mean   sd median trimmed  mad   min  max range  skew
## dep_var       1 100 3.94 1.89   3.78    3.88 2.23  0.30 7.56  7.27  0.19
## dep_var_z     2 100 0.00 1.00  -0.09   -0.03 1.18 -1.93 1.91  3.84  0.19
## confound      3 100 1.97 1.34   1.93    2.00 1.26 -1.27 4.46  5.73 -0.19
## confound_z    4 100 0.00 1.00  -0.03    0.03 0.93 -2.41 1.86  4.26 -0.19
##            kurtosis   se
## dep_var       -1.22 0.19
## dep_var_z     -1.22 0.10
## confound      -0.53 0.13
## confound_z    -0.53 0.10
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
## dep_var       1 50  2.33 0.81   2.39    2.31 0.80  0.30 4.08  3.78  0.10
## dep_var_z     2 50 -0.85 0.43  -0.82   -0.87 0.42 -1.93 0.07  2.00  0.10
## confound      3 50  1.27 1.14   1.35    1.26 1.09 -1.27 3.63  4.90 -0.07
## confound_z    4 50 -0.52 0.85  -0.46   -0.53 0.81 -2.41 1.23  3.64 -0.07
##            kurtosis   se
## dep_var       -0.29 0.12
## dep_var_z     -0.29 0.06
## confound      -0.33 0.16
## confound_z    -0.33 0.12
## -------------------------------------------------------- 
## condition: manipulation
##            vars  n mean   sd median trimmed  mad   min  max range  skew
## dep_var       1 50 5.55 1.13   5.58    5.60 0.97  2.82 7.56  4.75 -0.25
## dep_var_z     2 50 0.85 0.60   0.86    0.88 0.51 -0.60 1.91  2.51 -0.25
## confound      3 50 2.67 1.16   2.72    2.73 1.29 -0.97 4.46  5.43 -0.58
## confound_z    4 50 0.52 0.87   0.56    0.57 0.96 -2.18 1.86  4.04 -0.58
##            kurtosis   se
## dep_var       -0.45 0.16
## dep_var_z     -0.45 0.08
## confound       0.18 0.16
## confound_z     0.18 0.12
```

# read in your own data
> * .csv file: `read_csv()`
> * .txt file: `read_delim()`
> * SPSS .sav file: `read_sav()`

## SPSS
> * see help(read_sav) for details


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
> * see help(read_csv) for details


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
> * see help(read_delim) for details


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

## `t.test()`, help(t.test)


```r
t.test(dep_var ~ condition, data = example_data)
```

```
## 
## 	Welch Two Sample t-test
## 
## data:  dep_var by condition
## t = -16.396, df = 89.282, p-value < 2.2e-16
## alternative hypothesis: true difference in means is not equal to 0
## 95 percent confidence interval:
##  -3.612366 -2.831493
## sample estimates:
##      mean in group control mean in group manipulation 
##                   2.332125                   5.554054
```

## `pairs.panels()`, help(pairs.panels)
> shows a scatter plot of matrices (SPLOM), with bivariate scatter plots below the diagonal, histograms on the diagonal, and the Pearson correlation above the diagonal (see ?pairs.panels).


```r
example_data %>% 
  select(dep_var, confound, age) %>% 
  pairs.panels()
```

![](learn_r_for_psychology_research_a_crash_course_files/figure-html/unnamed-chunk-39-1.png)<!-- -->

## `lm()`, help(lm)


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
##                1.8766                 2.7208                 0.3589
```

## `summary()`, help(summary)


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
## -2.38376 -0.61179 -0.02486  0.48548  2.17222 
## 
## Coefficients:
##                       Estimate Std. Error t value Pr(>|t|)    
## (Intercept)            1.87659    0.16120   11.64  < 2e-16 ***
## conditionmanipulation  2.72080    0.21005   12.95  < 2e-16 ***
## confound               0.35890    0.07853    4.57 1.43e-05 ***
## ---
## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
## 
## Residual standard error: 0.8958 on 97 degrees of freedom
## Multiple R-squared:  0.7802,	Adjusted R-squared:  0.7757 
## F-statistic: 172.1 on 2 and 97 DF,  p-value: < 2.2e-16
```

## `Anova()`, help(Anova)


```r
lm_fit %>% Anova(type = "III")
```

```
## Anova Table (Type III tests)
## 
## Response: dep_var
##              Sum Sq Df F value    Pr(>F)    
## (Intercept) 108.761  1 135.528 < 2.2e-16 ***
## condition   134.643  1 167.779 < 2.2e-16 ***
## confound     16.763  1  20.889 1.435e-05 ***
## Residuals    77.843 97                      
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












