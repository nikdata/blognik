---
title: "Custom Summary Function"
authors: ["nikagarwal"]
date: 2017-12-28
output:
  html_document:
    keep_md: yes
---



## Background

In my previous course, PREDICT 454, one of the challenge assigments was to construct a custom function (i.e., user-defined) that could calculate the following:

* quantiles (1%, 5%, 10%, 90%, 95%, 99%)
* mean
* median
* variance
* min & max

Typically, when you execute a ```summary``` command in R, you see the following:


```r
summary(iris)
##   Sepal.Length    Sepal.Width     Petal.Length    Petal.Width   
##  Min.   :4.300   Min.   :2.000   Min.   :1.000   Min.   :0.100  
##  1st Qu.:5.100   1st Qu.:2.800   1st Qu.:1.600   1st Qu.:0.300  
##  Median :5.800   Median :3.000   Median :4.350   Median :1.300  
##  Mean   :5.843   Mean   :3.057   Mean   :3.758   Mean   :1.199  
##  3rd Qu.:6.400   3rd Qu.:3.300   3rd Qu.:5.100   3rd Qu.:1.800  
##  Max.   :7.900   Max.   :4.400   Max.   :6.900   Max.   :2.500  
##        Species  
##  setosa    :50  
##  versicolor:50  
##  virginica :50  
##                 
##                 
##
```

Note how the default ```summary``` command has some of the attributes needed, but not all (e.g., variance).

## Custom Summary Function

For this brief tutorial, I'm going to rely on the package ```tidyverse```. To put it simply, this is the only package I load at first since it makes my life a whole lot simpler. Furthermore, I'll use the ```iris``` dataset that is built into R.

### Load the data

First things first, I will load the ```tidyverse``` library and store the ```iris``` data in a new data frame called **df**. Next, we'll take a quick glimpse at it. I generally save imported data into a new data frame as it enables me to revert back to a 'clean' data frame if something goes awry later.


```r
library(tidyverse)
## ── Attaching packages ──────────────────────────────────────────────────────────────────────────────────────── tidyverse 1.2.1 ──
## ✔ ggplot2 2.2.1     ✔ purrr   0.2.4
## ✔ tibble  1.4.1     ✔ dplyr   0.7.4
## ✔ tidyr   0.7.2     ✔ stringr 1.2.0
## ✔ readr   1.1.1     ✔ forcats 0.2.0
## ── Conflicts ─────────────────────────────────────────────────────────────────────────────────────────── tidyverse_conflicts() ──
## ✖ dplyr::filter() masks stats::filter()
## ✖ dplyr::lag()    masks stats::lag()

df <- iris

glimpse(df)
## Observations: 150
## Variables: 5
## $ Sepal.Length <dbl> 5.1, 4.9, 4.7, 4.6, 5.0, 5.4, 4.6, 5.0, 4.4, 4.9,...
## $ Sepal.Width  <dbl> 3.5, 3.0, 3.2, 3.1, 3.6, 3.9, 3.4, 3.4, 2.9, 3.1,...
## $ Petal.Length <dbl> 1.4, 1.4, 1.3, 1.5, 1.4, 1.7, 1.4, 1.5, 1.4, 1.5,...
## $ Petal.Width  <dbl> 0.2, 0.2, 0.2, 0.2, 0.2, 0.4, 0.3, 0.2, 0.2, 0.1,...
## $ Species      <fctr> setosa, setosa, setosa, setosa, setosa, setosa, ...
```

### Custom Summary Code

Without further adieu, here's the code I used:


```r
custom.summary <- function(data, grp1, var1) {
  grp1 <- enquo(grp1)
  var1 <- enquo(var1)
  data %>%
    group_by(!!grp1) %>%
    summarize(
      q01 = quantile(!!var1, 0.01, na.rm = T),
      q05 = quantile(!!var1, 0.05, na.rm = T),
      q10 = quantile(!!var1, 0.1, na.rm = T),
      q90 = quantile(!!var1, 0.9, na.rm = T),
      q95 = quantile(!!var1, 0.95, na.rm = T),
      q99 = quantile(!!var1, 0.99, na.rm = T),
      min.val = min(!!var1, na.rm = T),
      max.val = max(!!var1, na.rm = T),
      mean.val = round(mean(!!var1, na.rm = T),3),
      median.val = round(median(!!var1, na.rm = T),3),
      var.val = round(var(!!var1, na.rm = T),3),
      sd.val = round(sd(!!var1, na.rm = T),3)
    ) %>%
    ungroup()
}
```

### Custom Summary Output

```r
options(width = 350)
custom.summary(df, Species, Sepal.Length)
## # A tibble: 3 x 13
##   Species      q01   q05   q10   q90   q95   q99 min.val max.val mean.val median.val var.val sd.val
##   <fctr>     <dbl> <dbl> <dbl> <dbl> <dbl> <dbl>   <dbl>   <dbl>    <dbl>      <dbl>   <dbl>  <dbl>
## 1 setosa      4.35  4.40  4.59  5.41  5.61  5.75    4.30    5.80     5.01       5.00   0.124  0.352
## 2 versicolor  4.95  5.04  5.38  6.70  6.76  6.95    4.90    7.00     5.94       5.90   0.266  0.516
## 3 virginica   5.24  5.74  5.80  7.61  7.70  7.80    4.90    7.90     6.59       6.50   0.404  0.636
```

### Code Explanation

#### Function Arguments
This user-defined function consists of three arguments: **data**, **grp1**, **var1**.

* **data** - This argument is for the data frame.

* **grp1** - This argument is for the grouping.

* **var1** - This argument is for the variable (must be numerical).

#### Enquo
One of the peculiar commands you'll note is the use of ```enquo```. This is actually quite important. The ```enquo``` command simply wraps the text that you have used in quotes. In other words, it's creating quoted expressions. Remember how you could use ```df$Species```? Instead of writing it out like that, I simply told the function to remember it as a quoted expression, so I don't have to put the '$' sign. And then to recall it correctly, I use the double exclamation (!!) in front of the variable name.

#### na.rm
The rest of the code is fairly self-explanatory. By default, a user-defined function automatically returns the last object. I did want to point out that the argument ```na.rm=T``` is quite important. It serves as an error-handling step in case there are null values. Remember, R can't calculate many values if null is amongst them.

## Hope that helps!
I hope this guide is a quick and easy read. Let me know if you have any questions.
