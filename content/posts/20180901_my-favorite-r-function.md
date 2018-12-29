---
title: "My Favorite R Function"
authors: ["nikagarwal"]
date: 2018-09-01
draft: FALSE
mathjax: TRUE
emoji: TRUE
---

The ``summary()`` function in R is my favorite R function. This simple base-R function has the ability to give you quite a bit of insight into your data that I wonder why more folks just don't sing its praises. I know it has its limitations, but I have a function that can address it (more on that below).

Allow me to show you how I use the ``summary()`` function and so you can also witness its awesomeness!

### Generate Example Data
For this example, I'm going to create some artificial data.

```r

library(tidyverse) # loading the best R library there is

set.seed(123) # setting a seed so that results can be reproduced

# using tibble() to generate fake data

df <- tibble(
  id = seq(1,100),
  age = sample(18:65, 100, replace = T),
  year = sample(2012:2018, 100, replace = T),
  loan = sample(5000:120000, 100, replace = T),
  home_state = sample(state.name, 100, replace = T)
  )

```

### Let's run summary()

Running the ``summary()`` on the example dataframe ``df`` gives us:

``` r
      id              age             year           loan         home_state       
Min.   :  1.00   Min.   :18.00   Min.   :2012   Min.   :  6064   Length:100        
1st Qu.: 25.75   1st Qu.:31.00   1st Qu.:2013   1st Qu.: 29755   Class :character  
Median : 50.50   Median :39.50   Median :2015   Median : 49534   Mode  :character  
Mean   : 50.50   Mean   :41.22   Mean   :2015   Mean   : 58916                     
3rd Qu.: 75.25   3rd Qu.:53.00   3rd Qu.:2017   3rd Qu.: 88914                     
Max.   :100.00   Max.   :64.00   Max.   :2018   Max.   :119178                   

```
In just one line, you already know the minimum, maximum, median, 25th percentile, and 75th percentile of each column in your data. Not shown is the fact that this function will also tell you how many missing observations (only if the dataset column contains 1 or more) there are.

A couple of issues exist though:

- you don't know the number of unique values in each column. This can be useful when trying to determine if your data needs reduced categorical variables
- the output is not in a tidy format. How can you use the results in other calculations?

### A Custom, More Powerful Summary

Naturally, I wrote a function that builds upon the summary. A few things that I like to know include:

- standard deviation
- 5th/95th percentiles
- 10th/90th percentiles
- number of unique values

So let's get to it (using the same example data above)

``` r

get_awesomesummary <- function(df) {

  tmp <- df %>%
    select_if(is.numeric)

  minval <- tmp %>%
    summarize_all(min) %>%
    gather(key = variable, value = min)

  maxval <- tmp %>%
    summarize_all(max) %>%
    gather(key = variable, value = max)

  medianval <- tmp %>%
    summarize_all(median) %>%
    gather(key = variable, value = median)

  meanval <- tmp %>%
    summarize_all(mean) %>%
    gather(key = variable, value = mean)

  sdval <- tmp %>%
    summarize_all(sd) %>%
    gather(key = variable, value = sd)

  p05 <- tmp %>%
    summarize_all(funs(quantile), probs = 0.05) %>%
    gather(key = variable, value = p05)

  p10 <- tmp %>%
    summarize_all(funs(quantile), probs = 0.10) %>%
    gather(key = variable, value = p10)

  p90 <- tmp %>%
    summarize_all(funs(quantile), probs = 0.90) %>%
    gather(key = variable, value = p90)

  p95 <- tmp %>%
    summarize_all(funs(quantile), probs = 0.95) %>%
    gather(key = variable, value = p95)

  u_count <- df %>%
    summarize_all(funs(length(unique(.)))) %>%
    gather(key = variable, value = unique)

  m_count <- df %>%
    summarize_all(funs(sum(is.na(.)))) %>%
    gather(key = variable, value = missing)

  # combine the outputs together

  combo <- tibble(variable = colnames(df)) %>%
    left_join(minval, by = 'variable') %>%
    left_join(maxval, by = 'variable') %>%
    left_join(medianval, by = 'variable') %>%
    left_join(meanval, by = 'variable') %>%
    left_join(sdval, by = 'variable') %>%
    left_join(p05, by = 'variable') %>%
    left_join(p10, by = 'variable') %>%
    left_join(p90, by = 'variable') %>%
    left_join(p95, by = 'variable') %>%
    left_join(u_count, by = 'variable') %>%
    left_join(m_count, by = 'variable')

  return(combo)

}
```

Here's the output:

``` r

# A tibble: 5 x 12
  variable     min    max  median    mean       sd      p05     p10      p90      p95 unique missing
  <chr>      <dbl>  <dbl>   <dbl>   <dbl>    <dbl>    <dbl>   <dbl>    <dbl>    <dbl>  <int>   <int>
1 id             1    100    50.5    50.5    29.0      5.95    10.9     90.1     95.0    100       0
2 age           18     64    39.5    41.2    14.0     20       21       61.1     63.0     41       0
3 year        2012   2018  2015    2015.      2.12  2012     2012     2018     2018        7       0
4 loan        6064 119178 49534.  58916.  33480.   14337.   22658.  112244.  116816.     100       0
5 home_state    NA     NA    NA      NA      NA       NA       NA       NA       NA       41       0

```

The function I wrote above is far more cumbersome to write every time (hence I just copy and paste). However, it also returns the results in a tidy dataframe - and that's important.

Hope that helps!
