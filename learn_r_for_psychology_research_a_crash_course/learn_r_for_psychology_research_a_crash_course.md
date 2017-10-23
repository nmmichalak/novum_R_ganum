# learn R for psychology research: a crash course
Nicholas Michalak  
October 23, 2017  

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

## packages: they're like apps you download for R
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

## objects: they save stuff for you
> "`object <- fuction(x)`, which means 'object is created from function(x)'. An object is anything created in R. It could be a variable, a collection of variables, a statistical model, etc. Objects can be single values (such as the mean of a set of scores) or collections of information; for example, when you run an analysis, you create an object that contains the output of that analysis, which means that this object contains many different values and variables. Functions are the things that you do in R to create your objects." **Source:** Field, A., Miles., J., & Field, Z. (2012). Discovering statistics using R. London: SAGE Publications.

## `c()` function: combine things like thing1, thing2, ...
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
> * read like this: generate a sequence of values from 1 to 100 by 1


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
> * read like this: replicate each element of c("control", "manipulation") 50 times, and then turn the result into a factor
> * side: in R, factors are nominal variables (i.e., integers) with value labels (i.e., names for each integer).


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
##  [1]  0.08125601 -0.41051741  0.26605981  0.08191790  0.70647809
##  [6] -0.22536287  0.74332971  2.11368267 -0.42594279  1.46729458
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
##   [1] 2.5435830 4.3236220 0.7451496 3.0580718 2.8854941 2.2942833 2.1753255
##   [8] 3.3899372 2.8832051 1.1432373 1.7081195 2.4233512 2.7096071 0.9788851
##  [15] 2.6601666 2.2670739 0.8324747 1.2472355 2.9624482 2.7350331 4.5603073
##  [22] 1.3881786 3.4966163 2.3100509 1.8429701 1.9399995 2.6893665 2.8231387
##  [29] 3.7517674 2.9231535 2.5872710 3.8347687 2.5131383 1.6323884 3.7907848
##  [36] 3.4196156 4.3911399 3.3296572 4.1328964 1.9112610 4.2293971 2.7292229
##  [43] 1.8884676 3.0504422 2.1882514 2.1335971 2.5885613 4.1854058 4.0461194
##  [50] 1.9281495 4.8709470 5.2113948 6.0862119 5.4777233 5.0309601 4.9954286
##  [57] 4.9208950 7.1638691 6.8163850 5.6146743 5.1604645 4.4506921 6.0234478
##  [64] 6.9177280 6.4030250 5.0158720 3.9712019 6.1342765 4.0277931 6.1661882
##  [71] 6.3251615 5.6675125 2.8871886 6.7152070 5.2122606 8.5822249 6.1276699
##  [78] 5.5380928 5.5592400 5.8081098 6.1968275 6.4674784 5.7453644 5.9454379
##  [85] 4.7747758 3.9599458 5.1814286 5.6581842 5.5181680 3.7009358 5.6726327
##  [92] 7.1131697 4.8326095 7.5638185 5.6739203 5.3667772 4.8108268 7.0192369
##  [99] 5.0916368 5.5246319
```

## create a potentially confounding variable or a control variable
> in the code below, we multiply every value in dep_var by 0.5 and then we "add noise": 100 random normal values whose true population has a mean = 0 and sd = 1. Every value in dep_var * 0.5 gets a random value added to it.


```r
confound <- dep_var * 0.5 + rnorm(n = 100, mean = 0, sd = 1)

# print confound by just excecuting/running the name of the object
confound
```

```
##   [1]  1.73009986  4.35895583  1.90824778  2.44175832  1.82859340
##   [6]  1.81374299  0.59161106  0.80141435  1.80680586  0.73611647
##  [11]  3.27006008  1.71094332  1.11664495 -0.20096132  0.70691604
##  [16] -0.11084319  0.39317643 -0.97864472  2.95781705 -0.37641110
##  [21]  3.53074293  0.95115515  0.30122394 -0.97882940  0.99980313
##  [26]  0.82327051  1.35193001  2.26692770 -0.09094577  1.07012604
##  [31]  2.18594198  2.42104024 -0.91851100  1.64804570  0.94315919
##  [36]  1.25675680  0.90232793 -1.46317961  3.31037840  1.11473100
##  [41]  1.58291366  2.80638339  1.58343683  1.05701150  0.73544605
##  [46]  0.45244054  0.40915437  3.18273652  2.44407516  1.21883173
##  [51]  2.18341508  2.75574288  2.80075580  2.79027905  1.11698827
##  [56]  1.73955888  1.95374328  5.22792164  2.38951510  3.09463446
##  [61]  2.24973107  0.98198341  0.85459318  2.06622957  3.70044614
##  [66]  2.94693074  2.70668941  3.99778513  0.99272672  5.93504717
##  [71]  3.46539370  3.20844852  1.20329233  4.34143401  2.96285835
##  [76]  4.47916451  3.74115287  4.44293433  4.18997621  3.75736837
##  [81]  3.65291479  2.94687073  0.97516826  4.25221376  3.06883978
##  [86]  1.74573326  2.65518197  1.90671429  3.04210774  2.38727488
##  [91]  2.00341057  2.40983568  3.65229577  4.74592641  3.26372360
##  [96]  1.84892020  1.98383434  1.95025462  3.23760436  2.76014769
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


```r
age <- seq(from = 18, to = 25, by = 1) %>% sample(size = 100, replace = TRUE)

# print gender by just excecuting/running the name of the object
age
```

```
##   [1] 24 25 25 19 24 23 24 22 20 21 23 23 20 24 23 21 22 18 18 24 20 20 19
##  [24] 20 19 23 18 25 20 20 23 18 22 20 24 23 21 19 22 21 25 22 20 20 21 25
##  [47] 23 21 25 18 18 22 24 18 22 22 20 20 20 23 21 19 25 20 22 21 23 21 20
##  [70] 21 22 18 19 23 19 20 21 24 19 20 24 18 19 24 18 21 22 19 25 24 19 19
##  [93] 19 21 20 22 22 25 22 21
```

## `data.frame()` and `tibble()`
> "The concept of a data frame comes from the world of statistical software used in empirical research; it generally refers to "tabular" data: a data structure representing cases (rows), each of which consists of a number of observations or measurements (columns). Alternatively, each row may be treated as a single observation of multiple "variables". In any case, each row and each column has the same data type, but the row ("record") datatype may be heterogenous (a tuple of different types), while the column datatype must be homogenous. Data frames usually contain some metadata in addition to data; for example, column and row names." **Source:** https://github.com/mobileink/data.frame/wiki/What-is-a-Data-Frame%3F

> "**Tibbles** are a modern take on data frames. They keep the features that have stood the test of time, and drop the features that used to be convenient but are now frustrating (i.e. converting character vectors to factors)." **Source:** https://cran.r-project.org/web/packages/tibble/vignettes/tibble.html

## put all our variable we made into a tibble
> * every variable we made above is seperated by a comma -- these will become columns in our dataset


```r
example_data <- tibble(subj_num, condition, dep_var, confound, gender, age)

# print example_data by just excecuting/running the name of the object
example_data
```

```
## # A tibble: 100 x 6
##    subj_num condition   dep_var  confound gender   age
##       <dbl>    <fctr>     <dbl>     <dbl> <fctr> <dbl>
##  1        1   control 2.5435830 1.7300999  Woman    24
##  2        2   control 4.3236220 4.3589558    Man    25
##  3        3   control 0.7451496 1.9082478  Woman    25
##  4        4   control 3.0580718 2.4417583    Man    19
##  5        5   control 2.8854941 1.8285934  Woman    24
##  6        6   control 2.2942833 1.8137430    Man    23
##  7        7   control 2.1753255 0.5916111  Woman    24
##  8        8   control 3.3899372 0.8014143    Man    22
##  9        9   control 2.8832051 1.8068059  Woman    20
## 10       10   control 1.1432373 0.7361165    Man    21
## # ... with 90 more rows
```

# data wrangling examples

## create new variables in data.frame or tibble
> * `mutate()` adds new variables to your tibble.
> * we're adding new columns to our dataset, and we're saving this new dataset as the same name as our old one (i.e., like changing an Excel file and saving with the same name)


```r
example_data <- example_data %>%
  mutate(dep_var_z = dep_var %>% scale() %>% parse_number(),
         confound_z = confound %>% scale() %>% parse_number())

# print example_data by just excecuting/running the name of the object
example_data
```

```
## # A tibble: 100 x 8
##    subj_num condition   dep_var  confound gender   age   dep_var_z
##       <dbl>    <fctr>     <dbl>     <dbl> <fctr> <dbl>       <dbl>
##  1        1   control 2.5435830 1.7300999  Woman    24 -0.90122863
##  2        2   control 4.3236220 4.3589558    Man    25  0.09801439
##  3        3   control 0.7451496 1.9082478  Woman    25 -1.91079751
##  4        4   control 3.0580718 2.4417583    Man    19 -0.61241508
##  5        5   control 2.8854941 1.8285934  Woman    24 -0.70929332
##  6        6   control 2.2942833 1.8137430    Man    23 -1.04117556
##  7        7   control 2.1753255 0.5916111  Woman    24 -1.10795372
##  8        8   control 3.3899372 0.8014143    Man    22 -0.42611908
##  9        9   control 2.8832051 1.8068059  Woman    20 -0.71057831
## 10       10   control 1.1432373 0.7361165    Man    21 -1.68732694
## # ... with 90 more rows, and 1 more variables: confound_z <dbl>
```

## select specific columns
> * `select()` selects your tibble's variables by name and in the exact order you specify.


```r
example_data %>% 
  select(subj_num, condition, dep_var)
```

```
## # A tibble: 100 x 3
##    subj_num condition   dep_var
##       <dbl>    <fctr>     <dbl>
##  1        1   control 2.5435830
##  2        2   control 4.3236220
##  3        3   control 0.7451496
##  4        4   control 3.0580718
##  5        5   control 2.8854941
##  6        6   control 2.2942833
##  7        7   control 2.1753255
##  8        8   control 3.3899372
##  9        9   control 2.8832051
## 10       10   control 1.1432373
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
##    subj_num condition   dep_var  confound gender   age   dep_var_z
##       <dbl>    <fctr>     <dbl>     <dbl> <fctr> <dbl>       <dbl>
##  1        1   control 2.5435830 1.7300999  Woman    24 -0.90122863
##  2        2   control 4.3236220 4.3589558    Man    25  0.09801439
##  3        3   control 0.7451496 1.9082478  Woman    25 -1.91079751
##  4        4   control 3.0580718 2.4417583    Man    19 -0.61241508
##  5        5   control 2.8854941 1.8285934  Woman    24 -0.70929332
##  6        6   control 2.2942833 1.8137430    Man    23 -1.04117556
##  7        7   control 2.1753255 0.5916111  Woman    24 -1.10795372
##  8        8   control 3.3899372 0.8014143    Man    22 -0.42611908
##  9        9   control 2.8832051 1.8068059  Woman    20 -0.71057831
## 10       10   control 1.1432373 0.7361165    Man    21 -1.68732694
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
##   gender    condition     Mean       SD     n
##   <fctr>       <fctr>    <dbl>    <dbl> <int>
## 1    Man      control 1.120941 1.373582    25
## 2    Man manipulation 3.148774 1.257496    25
## 3  Woman      control 1.423242 1.111816    25
## 4  Woman manipulation 2.561854 0.985989    25
```


# plotting your data with ggplot2
> "ggplot2 is a plotting system for R, based on the grammar of graphics, which tries to take the good parts of base and lattice graphics and none of the bad parts. It takes care of many of the fiddly details that make plotting a hassle (like drawing legends) as well as providing a powerful model of graphics that makes it easy to produce complex multi-layered graphics." **Source:**: http://ggplot2.org/

## make ggplots in layers
> * Aesthetic mappings describe how variables in the data are mapped to visual properties (aesthetics) of geoms. **Source:** http://ggplot2.tidyverse.org/reference/aes.html
> * Below, we map condition on our plot's x-axis and dep_var on its y-axis


```r
example_data %>%
  ggplot(mapping = aes(x = condition, y = dep_var))
```

![](learn_r_for_psychology_research_a_crash_course_files/figure-html/unnamed-chunk-26-1.png)<!-- -->

> * Think of this like a blank canvas that we're going to add pictures to or like a map of the ocean we're going to add land mass to

## boxplot
> * next, we add—yes, add, with a `+`—a geom, a geometric element: `geom_boxplot()`


```r
example_data %>%
  ggplot(mapping = aes(x = condition, y = dep_var)) +
  geom_boxplot()
```

![](learn_r_for_psychology_research_a_crash_course_files/figure-html/unnamed-chunk-27-1.png)<!-- -->

> * Here's emphasis: we started with a blank canvas, and we added a boxplot. All ggplots work this way: start with a base and add layers.

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
> * `stat_summary()` does what its name suggests: it applies statistical summaries to your raw data to make the geoms (bars and error bars in our case below)
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
  geom_smooth(method = "lm", se = TRUE)
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
##            vars   n mean   sd median trimmed  mad   min  max range skew
## dep_var       1 100 4.15 1.78   4.16    4.13 2.17  0.75 8.58  7.84 0.06
## dep_var_z     2 100 0.00 1.00   0.01   -0.01 1.22 -1.91 2.49  4.40 0.06
## confound      3 100 2.06 1.44   1.97    2.06 1.47 -1.46 5.94  7.40 0.03
## confound_z    4 100 0.00 1.00  -0.07    0.00 1.02 -2.45 2.69  5.15 0.03
##            kurtosis   se
## dep_var       -0.94 0.18
## dep_var_z     -0.94 0.10
## confound      -0.19 0.14
## confound_z    -0.19 0.10
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
##            vars  n  mean   sd median trimmed  mad   min  max range skew
## dep_var       1 50  2.68 0.98   2.67    2.69 1.07  0.75 4.56  3.82 0.04
## dep_var_z     2 50 -0.82 0.55  -0.83   -0.82 0.60 -1.91 0.23  2.14 0.04
## confound      3 50  1.27 1.25   1.12    1.27 1.04 -1.46 4.36  5.82 0.10
## confound_z    4 50 -0.55 0.87  -0.66   -0.55 0.72 -2.45 1.60  4.05 0.10
##            kurtosis   se
## dep_var       -0.72 0.14
## dep_var_z     -0.72 0.08
## confound      -0.20 0.18
## confound_z    -0.20 0.12
## -------------------------------------------------------- 
## condition: manipulation
##            vars  n mean   sd median trimmed  mad   min  max range skew
## dep_var       1 50 5.61 1.04   5.59    5.62 0.85  2.89 8.58  5.70 0.10
## dep_var_z     2 50 0.82 0.58   0.81    0.82 0.48 -0.71 2.49  3.20 0.10
## confound      3 50 2.86 1.16   2.80    2.83 1.25  0.85 5.94  5.08 0.32
## confound_z    4 50 0.55 0.81   0.51    0.53 0.87 -0.84 2.69  3.54 0.32
##            kurtosis   se
## dep_var         0.6 0.15
## dep_var_z       0.6 0.08
## confound       -0.3 0.16
## confound_z     -0.3 0.11
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
## t = -14.535, df = 97.647, p-value < 2.2e-16
## alternative hypothesis: true difference in means is not equal to 0
## 95 percent confidence interval:
##  -3.329976 -2.529915
## sample estimates:
##      mean in group control mean in group manipulation 
##                   2.684048                   5.613993
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
##                2.2176                 2.3494                 0.3667
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
## -2.17219 -0.55245 -0.08153  0.57528  2.37274 
## 
## Coefficients:
##                       Estimate Std. Error t value Pr(>|t|)    
## (Intercept)            2.21755    0.16148  13.733  < 2e-16 ***
## conditionmanipulation  2.34935    0.21880  10.737  < 2e-16 ***
## confound               0.36672    0.07653   4.792 5.95e-06 ***
## ---
## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
## 
## Residual standard error: 0.9109 on 97 degrees of freedom
## Multiple R-squared:  0.7438,	Adjusted R-squared:  0.7385 
## F-statistic: 140.8 on 2 and 97 DF,  p-value: < 2.2e-16
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
## (Intercept) 156.501  1 188.596 < 2.2e-16 ***
## condition    95.671  1 115.291 < 2.2e-16 ***
## confound     19.053  1  22.961 5.951e-06 ***
## Residuals    80.493 97                      
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












