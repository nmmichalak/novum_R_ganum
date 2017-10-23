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
##  [1] -0.48653597 -0.76886934 -0.79130958  0.28989633  2.31747836
##  [6] -2.21076057 -1.35016454  0.06155923  0.78222196 -1.06655775
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
##   [1] 1.6740984 4.1155903 3.5879306 3.6935082 2.9374669 1.4983048 4.4494074
##   [8] 2.5848871 2.8855188 2.8584878 2.6585988 2.0437733 3.2876937 3.2696568
##  [15] 1.6167307 1.6623505 4.2713853 1.7169204 3.8631340 0.8968026 3.5677995
##  [22] 2.7190394 2.1393597 1.6323291 2.2939096 2.2060632 0.7483573 2.6284642
##  [29] 3.3447119 2.1602614 1.7937636 3.4640706 1.2055607 1.0482453 3.0576036
##  [36] 0.5907464 1.2694512 0.7160801 1.6703230 0.7882854 1.5192681 1.9606742
##  [43] 1.8164081 2.5139679 2.6225467 3.9538594 2.3190092 3.6065597 1.5396868
##  [50] 1.7141681 4.7003541 4.2239190 7.4625001 7.8776507 5.9500597 4.5647215
##  [57] 4.0035787 6.5088464 5.5077304 6.3701498 5.3525212 5.7142928 2.9808634
##  [64] 7.0832602 6.8079433 6.0702947 6.3608261 5.8552274 6.1745042 6.6045247
##  [71] 5.5926201 3.3233602 5.7296930 6.0083323 4.5737050 6.7098909 5.6069049
##  [78] 6.0191007 5.0140720 3.6718672 4.7867198 4.5398561 5.6303734 6.0891587
##  [85] 4.8513913 4.4355909 5.4094901 6.5361754 6.2605149 7.7203861 5.1307904
##  [92] 6.5483217 4.7102793 5.0354726 5.3228003 4.4269823 6.4427152 5.5428823
##  [99] 4.4778309 6.3806789
```

## create a potentially confounding variable or a control variable
> in the code below, we multiply every value in dep_var by 0.5 and then we "add noise": 100 random normal values whose true population has a mean = 0 and sd = 1. Every value in dep_var * 0.5 gets a random value added to it.


```r
confound <- dep_var * 0.5 + rnorm(n = 100, mean = 0, sd = 1)

# print confound by just excecuting/running the name of the object
confound
```

```
##   [1] -0.44705357  3.42005304  0.13027706  3.67611404  1.86512465
##   [6]  1.55194543  2.83253258  0.87199978  2.15288647  0.57697489
##  [11]  0.05094554  1.93850372  1.77451298  1.38651814  1.37408999
##  [16] -0.50980011  1.99736066  2.13988381  0.38334554  0.55773801
##  [21]  2.26138376  1.31703769 -0.74863282  0.62295460  2.05035256
##  [26]  0.62646411  0.89300155  2.17774952 -0.05929034  1.30680628
##  [31] -0.28297473  1.47631037  1.29206720  0.35926958  1.40206715
##  [36]  0.35258778  1.02206128  0.67334956  1.57139000  1.43323218
##  [41]  0.42944762  2.56225601 -0.69110699  1.90794667  1.99737086
##  [46]  2.75453188  1.93750360  2.30239977  1.86092144  1.20386500
##  [51]  2.14726445  2.32560738  2.60135282  3.08784459  3.54012049
##  [56]  3.64564750  0.22382197  3.92054666  2.97806210  2.59447087
##  [61]  2.56206067  2.22638756  0.23218539  4.49377084  3.71937552
##  [66]  4.59322602  1.70391232  1.94003009  3.82690015  2.35955223
##  [71]  2.94304179  1.68093548  3.31253752  4.10811925  2.30944360
##  [76]  2.88434278  2.89824335  3.59417723  2.25021167  3.40556773
##  [81]  1.82000011  0.79702398  1.45058934  3.71971200  3.25164065
##  [86]  1.06792349  3.24336754  2.55024709  3.12158089  1.97642576
##  [91]  2.67864664  2.36535482  1.59923967  1.30951029  0.78644955
##  [96]  2.43408448  3.55628508  4.08741766  2.22322238  2.15029620
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
##   [1] 20 22 22 25 24 18 25 25 22 22 23 18 21 21 23 18 20 18 20 22 23 20 22
##  [24] 22 21 23 24 19 18 18 21 24 24 21 23 20 25 23 23 23 24 18 18 21 21 20
##  [47] 23 22 22 20 23 23 24 22 22 22 25 20 21 18 19 23 25 24 24 19 24 19 19
##  [70] 19 22 21 24 24 22 19 24 23 23 20 22 24 23 19 18 24 18 18 20 25 23 24
##  [93] 18 21 20 19 22 21 18 18
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
##    subj_num condition  dep_var   confound gender   age
##       <dbl>    <fctr>    <dbl>      <dbl> <fctr> <dbl>
##  1        1   control 1.674098 -0.4470536  Woman    20
##  2        2   control 4.115590  3.4200530    Man    22
##  3        3   control 3.587931  0.1302771  Woman    22
##  4        4   control 3.693508  3.6761140    Man    25
##  5        5   control 2.937467  1.8651247  Woman    24
##  6        6   control 1.498305  1.5519454    Man    18
##  7        7   control 4.449407  2.8325326  Woman    25
##  8        8   control 2.584887  0.8719998    Man    25
##  9        9   control 2.885519  2.1528865  Woman    22
## 10       10   control 2.858488  0.5769749    Man    22
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
##    subj_num condition  dep_var   confound gender   age   dep_var_z
##       <dbl>    <fctr>    <dbl>      <dbl> <fctr> <dbl>       <dbl>
##  1        1   control 1.674098 -0.4470536  Woman    20 -1.19266170
##  2        2   control 4.115590  3.4200530    Man    22  0.07626853
##  3        3   control 3.587931  0.1302771  Woman    22 -0.19797503
##  4        4   control 3.693508  3.6761140    Man    25 -0.14310259
##  5        5   control 2.937467  1.8651247  Woman    24 -0.53604416
##  6        6   control 1.498305  1.5519454    Man    18 -1.28402787
##  7        7   control 4.449407  2.8325326  Woman    25  0.24976517
##  8        8   control 2.584887  0.8719998    Man    25 -0.71929240
##  9        9   control 2.885519  2.1528865  Woman    22 -0.56304340
## 10       10   control 2.858488  0.5769749    Man    22 -0.57709240
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
##    subj_num condition  dep_var
##       <dbl>    <fctr>    <dbl>
##  1        1   control 1.674098
##  2        2   control 4.115590
##  3        3   control 3.587931
##  4        4   control 3.693508
##  5        5   control 2.937467
##  6        6   control 1.498305
##  7        7   control 4.449407
##  8        8   control 2.584887
##  9        9   control 2.885519
## 10       10   control 2.858488
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
##  1        1   control 1.674098 -0.4470536  Woman    20 -1.19266170
##  2        2   control 4.115590  3.4200530    Man    22  0.07626853
##  3        3   control 3.587931  0.1302771  Woman    22 -0.19797503
##  4        4   control 3.693508  3.6761140    Man    25 -0.14310259
##  5        5   control 2.937467  1.8651247  Woman    24 -0.53604416
##  6        6   control 1.498305  1.5519454    Man    18 -1.28402787
##  7        7   control 4.449407  2.8325326  Woman    25  0.24976517
##  8        8   control 2.584887  0.8719998    Man    25 -0.71929240
##  9        9   control 2.885519  2.1528865  Woman    22 -0.56304340
## 10       10   control 2.858488  0.5769749    Man    22 -0.57709240
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
## 1    Man      control 1.467468 1.003229    25
## 2    Man manipulation 2.772729 1.057510    25
## 3  Woman      control 1.081983 1.041621    25
## 4  Woman manipulation 2.439182 1.014787    25
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
##            vars   n mean   sd median trimmed  mad   min  max range  skew
## dep_var       1 100 3.97 1.92   3.98    3.96 2.48  0.59 7.88  7.29  0.04
## dep_var_z     2 100 0.00 1.00   0.01    0.00 1.29 -1.76 2.03  3.79  0.04
## confound      3 100 1.94 1.23   1.99    1.95 1.21 -0.75 4.59  5.34 -0.09
## confound_z    4 100 0.00 1.00   0.04    0.01 0.98 -2.19 2.16  4.35 -0.09
##            kurtosis   se
## dep_var       -1.17 0.19
## dep_var_z     -1.17 0.10
## confound      -0.59 0.12
## confound_z    -0.59 0.10
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
## dep_var       1 50  2.36 1.03   2.25    2.34 1.04  0.59 4.45  3.86  0.19
## dep_var_z     2 50 -0.83 0.53  -0.89   -0.84 0.54 -1.76 0.25  2.01  0.19
## confound      3 50  1.27 1.03   1.38    1.28 1.12 -0.75 3.68  4.42 -0.02
## confound_z    4 50 -0.54 0.84  -0.46   -0.54 0.91 -2.19 1.41  3.60 -0.02
##            kurtosis   se
## dep_var       -0.99 0.15
## dep_var_z     -0.99 0.08
## confound      -0.51 0.15
## confound_z    -0.51 0.12
## -------------------------------------------------------- 
## condition: manipulation
##            vars  n mean   sd median trimmed  mad   min  max range  skew
## dep_var       1 50 5.57 1.08   5.62    5.59 1.18  2.98 7.88  4.90 -0.15
## dep_var_z     2 50 0.83 0.56   0.86    0.84 0.61 -0.51 2.03  2.55 -0.15
## confound      3 50 2.61 1.04   2.58    2.65 1.04  0.22 4.59  4.37 -0.30
## confound_z    4 50 0.54 0.85   0.52    0.58 0.85 -1.40 2.16  3.56 -0.30
##            kurtosis   se
## dep_var       -0.35 0.15
## dep_var_z     -0.35 0.08
## confound      -0.42 0.15
## confound_z    -0.42 0.12
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
## t = -15.232, df = 97.738, p-value < 2.2e-16
## alternative hypothesis: true difference in means is not equal to 0
## 95 percent confidence interval:
##  -3.628649 -2.792108
## sample estimates:
##      mean in group control mean in group manipulation 
##                   2.363656                   5.574035
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
##                1.7736                 2.5941                 0.4629
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
## -2.27233 -0.63571 -0.06603  0.69760  2.43778 
## 
## Coefficients:
##                       Estimate Std. Error t value Pr(>|t|)    
## (Intercept)            1.77355    0.17769   9.981  < 2e-16 ***
## conditionmanipulation  2.59412    0.22500  11.530  < 2e-16 ***
## confound               0.46292    0.09207   5.028 2.27e-06 ***
## ---
## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
## 
## Residual standard error: 0.9434 on 97 degrees of freedom
## Multiple R-squared:  0.7644,	Adjusted R-squared:  0.7596 
## F-statistic: 157.4 on 2 and 97 DF,  p-value: < 2.2e-16
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
## (Intercept)  88.666  1  99.621 < 2.2e-16 ***
## condition   118.313  1 132.932 < 2.2e-16 ***
## confound     22.501  1  25.281 2.269e-06 ***
## Residuals    86.333 97                      
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












