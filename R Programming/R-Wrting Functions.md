# R Wrting Functions 

1. Calling functions
One way to make your code more readable is to be careful about the order you pass arguments when you call functions, and whether you pass the arguments by position or by name.

gold_medals, a numeric vector of the number of gold medals won by each country in the 2016 Summer Olympics, is provided.

For convenience, the arguments of median() and rank() are displayed using args(). Setting rank()'s na.last argument to "keep" means "keep the rank of NA values as NA".

Best practice for calling functions is to include them in the order shown by args(), and to only name rare arguments.


```r
# Look at the gold medals data
gold_medals

# Note the arguments to median()
args(median)

# Rewrite this function call, following best practices
median(gold_medals, na.rm=TRUE)
```

```r
# Note the arguments to rank()
args(rank)

# Rewrite this function call, following best practices
rank(-gold_medals,na.last = "keep",ties.method ="min")
```

## First function

```r
# Your functions, from previous steps
toss_coin <- function() {
  coin_sides <- c("head", "tail")
  sample(coin_sides, 1)
}

# Call your function
toss_coin()
```

```r
# Update the function to return n coin tosses
toss_coin <- function(n_flips) {
  coin_sides <- c("head", "tail")
  sample(coin_sides, n_flips, replace=TRUE)
}

# Generate 10 coin tosses
toss_coin(10)
```

## Multiple inputs to functions

```r
# Update the function so heads have probability p_head
 toss_coin<- function(n_flips, p_head) {
  coin_sides <- c("head", "tail")
  # Define a vector of weights
  weights <- c(p_head, 1- p_head) 
  # Modify the sampling to be weighted
  sample(coin_sides, n_flips, replace = TRUE,  prob=weights)
}

# Generate 10 coin tosses
toss_coin(10,0.8)
```

## Renaming GLM 

```r
# Run a generalized linear regression 
glm(
  # Model no. of visits vs. gender, income, travel
  n_visits ~ gender + income + travel, 
  # Use the snake_river_visits dataset
  data = snake_river_visits, 
  # Make it a Poisson regression
  family = poisson
)
```

```r
# From previous step
run_poisson_regression <- function(data, formula) {
  glm(formula, data, family = poisson)
}

# Re-run the Poisson regression, using your function
model <- snake_river_visits %>%
  run_poisson_regression(n_visits ~ gender + income + travel)

# Run this to see the predictions
snake_river_explanatory %>%
  mutate(predicted_n_visits = predict(model, ., type = "response"))%>%
  arrange(desc(predicted_n_visits))
```

## Numeric defaults
cut_by_quantile() converts a numeric vector into a categorical variable where quantiles define the cut points. This is a useful function, but at the moment you have to specify five arguments to make it work. This is too much thinking and typing.

By specifying default arguments, you can make it easier to use. Let's start with n, which specifies how many categories to cut x into.

A numeric vector of the number of visits to Snake River is provided as n_visits.

```r
# Set the default for n to 5
cut_by_quantile <- function(x, n=5, na.rm, labels, interval_type) {
  probs <- seq(0, 1, length.out = n + 1)
  qtiles <- quantile(x, probs, na.rm = na.rm, names = FALSE)
  right <- switch(interval_type, "(lo, hi]" = TRUE, "[lo, hi)" = FALSE)
  cut(x, qtiles, labels = labels, right = right, include.lowest = TRUE)
}

# Remove the n argument from the call
cut_by_quantile(
  n_visits, 

  na.rm = FALSE, 
  labels = c("very low", "low", "medium", "high", "very high"),
  interval_type = "(lo, hi]"
)
```
## Categorical defaults
When cutting up a numeric vector, you need to worry about what happens if a value lands exactly on a boundary. You can either put this value into a category of the lower interval or the higher interval. That is, you can choose your intervals to include values at the top boundary but not the bottom (in mathematical terminology, "open on the left, closed on the right", or (lo, hi]). Or you can choose the opposite ("closed on the left, open on the right", or [lo, hi)). cut_by_quantile() should allow these two choices.

The pattern for categorical defaults is:
```c
function(cat_arg = c("choice1", "choice2")) {
  cat_arg <- match.arg(cat_arg)
}
```
Free hint: In the console, type head(rank) to see the start of rank()'s definition, and look at the ties.method argument.

```r
# Set the categories for interval_type to "(lo, hi]" and "[lo, hi)"
cut_by_quantile <- function(x, n = 5, na.rm = FALSE, labels = NULL, 
                            interval_type = c("(lo, hi]" ,"[lo, hi)")) {
  # Match the interval_type argument
  interval_type <- match.arg(interval_type)
  probs <- seq(0, 1, length.out = n + 1)
  qtiles <- quantile(x, probs, na.rm = na.rm, names = FALSE)
  right <- switch(interval_type, "(lo, hi]" = TRUE, "[lo, hi)" = FALSE)
  cut(x, qtiles, labels = labels, right = right, include.lowest = TRUE)
}

# Remove the interval_type argument from the call
cut_by_quantile(n_visits)

```

## Harmonic mean
The harmonic mean is the reciprocal of the arithmetic mean of the reciprocal of the data. That is


The harmonic mean is often used to average ratio data. You'll be using it on the price/earnings ratio of stocks in the Standard and Poor's 500 index, provided as std_and_poor500. Price/earnings ratio is a measure of how expensive a stock is.

The dplyr package is loaded.

```r

# From previous steps
get_reciprocal <- function(x) {
  1 / x
}
calc_harmonic_mean <- function(x) {
  x %>%
    get_reciprocal() %>%
    mean() %>%
    get_reciprocal()
}

std_and_poor500 %>% 
  # Group by sector
  group_by(sector) %>% 
  # Summarize, calculating harmonic mean of P/E ratio
  summarize(hmean_pe_ratio = calc_harmonic_mean(pe_ratio))

```

## Dealing with missing values
In the last exercise, many sectors had an NA value for the harmonic mean. It would be useful for your function to be able to remove missing values before calculating.

Rather than writing your own code for this, you can outsource this functionality to mean().

The dplyr package is loaded.

```r
# From previous step
calc_harmonic_mean <- function(x, na.rm = FALSE) {
  x %>%
    get_reciprocal() %>%
    mean(na.rm = na.rm) %>%
    get_reciprocal()
}

std_and_poor500 %>% 
  # Group by sector
  group_by(sector) %>% 
  # Summarize, calculating harmonic mean of P/E ratio
  summarise(hmean_pe_ratio = calc_harmonic_mean(pe_ratio, na.rm=TRUE))
```

## Throwing errors with bad arguments
If a user provides a bad input to a function, the best course of action is to throw an error letting them know. The two rules are

Throw the error message as soon as you realize there is a problem (typically at the start of the function).
Make the error message easily understandable.
You can use the assert_*() functions from assertive to check inputs and throw errors when they fail

```r
calc_harmonic_mean <- function(x, na.rm = FALSE) {
  # Assert that x is numeric
  assert_is_numeric(x)
  x %>%
    get_reciprocal() %>%
    mean(na.rm = na.rm) %>%
    get_reciprocal()
}

# See what happens when you pass it strings
calc_harmonic_mean(std_and_poor500$sector)

```