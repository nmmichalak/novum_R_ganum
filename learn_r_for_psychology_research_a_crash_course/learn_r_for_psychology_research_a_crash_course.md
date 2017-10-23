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
##  [1]  0.71318382  2.11015428  1.76774781  0.60311017  0.75259166
##  [6]  0.27464604  0.08178714  0.32902248  2.06258768 -0.03939587
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
##   [1]  2.28050831  2.47449115  1.21317047  1.26785107  3.22856651
##   [6]  3.90817921  1.15462369  1.93100730  2.93432424  0.79294591
##  [11]  2.80934716  1.68207717  2.60317116 -0.01282424  3.12291452
##  [16]  1.86024806  2.14001759  1.96535026  2.29664258  2.04080941
##  [21]  2.06507557  2.96204636  5.11385140  1.84633844  2.13437221
##  [26]  2.25461850  3.68181214  4.12556181  2.51658803  4.44504049
##  [31]  2.66254915  2.00797479  2.08901957  1.62804652  2.39684381
##  [36]  3.35443934  3.84444097  3.50503293  1.50229239  3.49686435
##  [41]  4.71177200  3.22279845  1.89466612  1.64590477  2.47847777
##  [46]  2.49317638  1.77623014  2.61054153  3.60526875  2.60579206
##  [51]  4.28039472  4.89685803  3.66886216  5.12358804  5.68814703
##  [56]  6.67109673  4.25186916  5.93952101  5.50702428  6.68222232
##  [61]  5.20725093  5.46512488  4.54971994  3.73407786  5.35759561
##  [66]  5.04961539  6.35838732  5.61295634  5.12082880  7.60628299
##  [71]  5.67578659  3.98428570  4.98913242  5.35612939  5.86895642
##  [76]  7.81667050  6.16509330  4.74951785  5.99983929  5.18929361
##  [81]  4.14775196  4.91399793  5.41192972  6.36582198  6.73918604
##  [86]  6.84736081  5.99065916  5.80832408  6.93667401  6.40843665
##  [91]  4.50196634  7.97910841  6.78448306  3.94359098  5.67015469
##  [96]  6.29252769  5.65147985  4.78288646  5.93642553  5.28765648
```

## create a potentially confounding variable or a control variable
> in the code below, we multiply every value in dep_var by 0.5 and then we "add noise": 100 random normal values whose true population has a mean = 0 and sd = 1. Every value in dep_var * 0.5 gets a random value added to it.


```r
confound <- dep_var * 0.5 + rnorm(n = 100, mean = 0, sd = 1)

# print confound by just excecuting/running the name of the object
confound
```

```
##   [1]  2.26903428  1.78604792  1.96608904 -0.50693187  0.72788296
##   [6]  0.52372390  2.37122913 -0.10754485  0.29067535  2.23871353
##  [11]  1.38382856  0.93046802  0.82902514 -1.73298639  1.80173467
##  [16] -0.46009198  1.84786908  0.65263341  1.82464339  0.99468434
##  [21]  1.67458092 -0.81106679  3.32330621  1.59236142  2.17758753
##  [26]  2.41289457  1.90130968  2.47687672  3.14694504  2.20425894
##  [31]  1.27290886  1.49498524  0.20561892  0.47339941 -0.24494544
##  [36]  0.37426760  2.46071113  1.75152245 -0.07848232  3.59482890
##  [41]  1.72907392  0.77386960  1.67292487 -0.41387572  1.74459955
##  [46]  0.96560246  0.54783982  1.89602974  3.11548784  2.71232885
##  [51]  3.38181834  2.91631534  2.50019647  1.47477471  3.44478977
##  [56]  2.88742629  1.20189726  2.14750659  1.23952240  3.69515407
##  [61]  2.53967695  4.07426194  2.36745796  1.14600557  1.59914891
##  [66]  2.39505202  4.52614693  4.06152712  2.31230736  5.16248130
##  [71]  2.19777997  1.80189199  1.37584730  2.80303871  3.52088637
##  [76]  4.89559352  1.55932167  0.65254457  2.02801926  1.34666572
##  [81]  2.37585662  2.55817516  1.65146616  1.98262039  3.61256346
##  [86]  3.50347127  3.65808144  3.87157911  4.33630431  3.08176691
##  [91]  2.80424787  3.01241217  3.89610556  1.18488222  1.88230594
##  [96]  2.97492357  1.52494218  2.96767425  4.47433188  0.40445470
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
##   [1] 20 22 25 23 22 20 19 19 19 21 21 25 24 23 25 23 25 19 22 18 20 22 21
##  [24] 21 25 24 18 24 25 22 25 25 23 18 23 23 20 25 24 21 23 25 21 20 19 18
##  [47] 23 21 20 20 18 20 23 25 20 24 18 19 21 20 25 25 20 24 21 21 20 23 24
##  [70] 19 25 22 22 23 18 20 18 20 22 19 22 22 23 25 25 18 18 21 21 24 25 19
##  [93] 25 24 19 22 25 23 18 25
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
##    subj_num condition   dep_var   confound gender   age
##       <dbl>    <fctr>     <dbl>      <dbl> <fctr> <dbl>
##  1        1   control 2.2805083  2.2690343  Woman    20
##  2        2   control 2.4744912  1.7860479    Man    22
##  3        3   control 1.2131705  1.9660890  Woman    25
##  4        4   control 1.2678511 -0.5069319    Man    23
##  5        5   control 3.2285665  0.7278830  Woman    22
##  6        6   control 3.9081792  0.5237239    Man    20
##  7        7   control 1.1546237  2.3712291  Woman    19
##  8        8   control 1.9310073 -0.1075449    Man    19
##  9        9   control 2.9343242  0.2906754  Woman    19
## 10       10   control 0.7929459  2.2387135    Man    21
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
##    subj_num condition   dep_var   confound gender   age   dep_var_z
##       <dbl>    <fctr>     <dbl>      <dbl> <fctr> <dbl>       <dbl>
##  1        1   control 2.2805083  2.2690343  Woman    20 -0.96533515
##  2        2   control 2.4744912  1.7860479    Man    22 -0.85971043
##  3        3   control 1.2131705  1.9660890  Woman    25 -1.54650647
##  4        4   control 1.2678511 -0.5069319    Man    23 -1.51673258
##  5        5   control 3.2285665  0.7278830  Woman    22 -0.44911226
##  6        6   control 3.9081792  0.5237239    Man    20 -0.07905941
##  7        7   control 1.1546237  2.3712291  Woman    19 -1.57838551
##  8        8   control 1.9310073 -0.1075449    Man    19 -1.15564037
##  9        9   control 2.9343242  0.2906754  Woman    19 -0.60932879
## 10       10   control 0.7929459  2.2387135    Man    21 -1.77532104
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
##  1        1   control 2.2805083
##  2        2   control 2.4744912
##  3        3   control 1.2131705
##  4        4   control 1.2678511
##  5        5   control 3.2285665
##  6        6   control 3.9081792
##  7        7   control 1.1546237
##  8        8   control 1.9310073
##  9        9   control 2.9343242
## 10       10   control 0.7929459
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
##  1        1   control 2.2805083  2.2690343  Woman    20 -0.96533515
##  2        2   control 2.4744912  1.7860479    Man    22 -0.85971043
##  3        3   control 1.2131705  1.9660890  Woman    25 -1.54650647
##  4        4   control 1.2678511 -0.5069319    Man    23 -1.51673258
##  5        5   control 3.2285665  0.7278830  Woman    22 -0.44911226
##  6        6   control 3.9081792  0.5237239    Man    20 -0.07905941
##  7        7   control 1.1546237  2.3712291  Woman    19 -1.57838551
##  8        8   control 1.9310073 -0.1075449    Man    19 -1.15564037
##  9        9   control 2.9343242  0.2906754  Woman    19 -0.60932879
## 10       10   control 0.7929459  2.2387135    Man    21 -1.77532104
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
##   gender    condition     Mean        SD     n
##   <fctr>       <fctr>    <dbl>     <dbl> <int>
## 1    Man      control 1.032680 1.2720251    25
## 2    Man manipulation 2.680088 1.2475452    25
## 3  Woman      control 1.598459 0.9724896    25
## 4  Woman manipulation 2.640441 1.0584074    25
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
## dep_var       1 100 4.05 1.84   4.05    4.03 2.34 -0.01 7.98  7.99  0.05
## dep_var_z     2 100 0.00 1.00   0.00   -0.01 1.27 -2.21 2.14  4.35  0.05
## confound      3 100 1.99 1.33   1.90    2.00 1.34 -1.73 5.16  6.90 -0.06
## confound_z    4 100 0.00 1.00  -0.07    0.01 1.01 -2.80 2.39  5.19 -0.06
##            kurtosis   se
## dep_var       -1.03 0.18
## dep_var_z     -1.03 0.10
## confound      -0.13 0.13
## confound_z    -0.13 0.10
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
## dep_var       1 50  2.53 1.01   2.44    2.49 0.86 -0.01 5.11  5.13  0.31
## dep_var_z     2 50 -0.83 0.55  -0.88   -0.85 0.47 -2.21 0.58  2.79  0.31
## confound      3 50  1.32 1.16   1.63    1.35 1.17 -1.73 3.59  5.33 -0.33
## confound_z    4 50 -0.51 0.87  -0.27   -0.48 0.88 -2.80 1.21  4.01 -0.33
##            kurtosis   se
## dep_var        0.13 0.14
## dep_var_z      0.13 0.08
## confound      -0.38 0.16
## confound_z    -0.38 0.12
## -------------------------------------------------------- 
## condition: manipulation
##            vars  n mean   sd median trimmed  mad   min  max range skew
## dep_var       1 50 5.58 1.02   5.56    5.56 0.97  3.67 7.98  4.31 0.23
## dep_var_z     2 50 0.83 0.55   0.82    0.82 0.53 -0.21 2.14  2.35 0.23
## confound      3 50 2.66 1.15   2.55    2.63 1.41  0.40 5.16  4.76 0.18
## confound_z    4 50 0.51 0.86   0.42    0.48 1.06 -1.19 2.39  3.58 0.18
##            kurtosis   se
## dep_var       -0.36 0.14
## dep_var_z     -0.36 0.08
## confound      -0.82 0.16
## confound_z    -0.82 0.12
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
## t = -15.027, df = 97.996, p-value < 2.2e-16
## alternative hypothesis: true difference in means is not equal to 0
## 95 percent confidence interval:
##  -3.454949 -2.648878
## sample estimates:
##      mean in group control mean in group manipulation 
##                   2.527417                   5.579331
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
##                1.9400                 2.4515                 0.4465
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
## -2.14668 -0.62047 -0.04126  0.64081  2.24253 
## 
## Coefficients:
##                       Estimate Std. Error t value Pr(>|t|)    
## (Intercept)            1.93998    0.16073  12.069  < 2e-16 ***
## conditionmanipulation  2.45147    0.20445  11.991  < 2e-16 ***
## confound               0.44653    0.07728   5.778 9.13e-08 ***
## ---
## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
## 
## Residual standard error: 0.8804 on 97 degrees of freedom
## Multiple R-squared:  0.7749,	Adjusted R-squared:  0.7702 
## F-statistic: 166.9 on 2 and 97 DF,  p-value: < 2.2e-16
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
## (Intercept) 112.901  1  145.67 < 2.2e-16 ***
## condition   111.432  1  143.78 < 2.2e-16 ***
## confound     25.878  1   33.39 9.129e-08 ***
## Residuals    75.178 97                      
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












