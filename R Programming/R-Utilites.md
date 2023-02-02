# Mathematical utilities

```r
# The errors vector has already been defined for you
errors <- c(1.9, -2.6, 4.0, -9.5, -3.4, 7.3)

# Sum of absolute rounded values of errors
sum(round(abs(errors)))
```

## Data Utilities
R features a bunch of functions to juggle around with data structures::

seq(): Generate sequences, by specifying the from, to, and by arguments.
rep(): Replicate elements of vectors and lists.
sort(): Sort a vector in ascending order. Works on numerics, but also on character strings and logicals.
rev(): Reverse the elements in a data structures for which reversal is defined.
str(): Display the structure of any R object.
append(): Merge vectors or lists.
is.*(): Check for the class of an R object.
as.*(): Convert an R object from one class to another.
unlist(): Flatten (possibly embedded) lists to produce a vector.
Remember the social media profile views data? Your LinkedIn and Facebook view counts for the last seven days have been pre-defined as lists.

```r
# The linkedin and facebook lists have already been created for you
linkedin <- list(16, 9, 13, 5, 2, 17, 14)
facebook <- list(17, 7, 5, 16, 8, 13, 14)

# Convert linkedin and facebook to a vector: li_vec and fb_vec
li_vec = unlist(linkedin)
fb_vec = unlist(facebook)


# Append fb_vec to li_vec: social_vec
social_vec = append(li_vec, fb_vec)

# Sort social_vec
sort(social_vec, decreasing = TRUE)

```

```r
rep(seq(1, 7, by = 2), times = 7)
```



## Regular Expressions

grepl & grep
In their most basic form, regular expressions can be used to see whether a pattern exists inside a character string or a vector of character strings. For this purpose, you can use:

grepl(), which returns TRUE when a pattern is found in the corresponding character string.
grep(), which returns a vector of indices of the character strings that contains the pattern.
Both functions need a pattern and an x argument, where pattern is the regular expression you want to match for, and the x argument is the character vector from which matches should be sought.

In this and the following exercises, you'll be querying and manipulating a character vector of email addresses! The vector emails has been pre-defined so you can begin with the instructions straight away!


```r
# The emails vector has already been defined for you
emails <- c("john.doe@ivyleague.edu", "education@world.gov", "dalai.lama@peace.org",
            "invalid.edu", "quant@bigdatacollege.edu", "cookie.monster@sesame.tv")

# Use grepl() to match for "edu"
grepl(pattern="edu",emails)

# Use grep() to match for "edu", save result to hits
hits <-grep(pattern="edu",emails)

# Subset emails using hits
emails[hits]
```

You can use the caret, ^, and the dollar sign, $ to match the content located in the start and end of a string, respectively. This could take us one step closer to a correct pattern for matching only the ".edu" email addresses from our list of emails. But there's more that can be added to make the pattern more robust:

@, because a valid email must contain an at-sign.
.*, which matches any character (.) zero or more times (*). Both the dot and the asterisk are metacharacters. You can use them to match any character between the at-sign and the ".edu" portion of an email address.
\\.edu$, to match the ".edu" part of the email at the end of the string. The \\ part escapes the dot: it tells R that you want to use the . as an actual character.


```r
# The emails vector has already been defined for you
emails <- c("john.doe@ivyleague.edu", "education@world.gov", "dalai.lama@peace.org",
            "invalid.edu", "quant@bigdatacollege.edu", "cookie.monster@sesame.tv")

# Use grepl() to match for .edu addresses more robustly
grepl(pattern="@.*\\.edu$", emails)

# Use grep() to match for .edu addresses more robustly, save result to hits
hits <- grep(pattern="@.*\\.edu$", emails)

# Subset emails using hits
emails[hits]
```

```c
[1]  TRUE FALSE FALSE FALSE  TRUE FALSE

emails[hits]
[1] "john.doe@ivyleague.edu"   "quant@bigdatacollege.edu"
```

# sub & gsub
While grep() and grepl() were used to simply check whether a regular expression could be matched with a character vector, sub() and gsub() take it one step further: you can specify a replacement argument. If inside the character vector x, the regular expression pattern is found, the matching element(s) will be replaced with replacement. sub() only replaces the first match, whereas gsub() replaces all matches.

```r
# The emails vector has already been defined for you
emails <- c("john.doe@ivyleague.edu", "education@world.gov", "global@peace.org",
            "invalid.edu", "quant@bigdatacollege.edu", "cookie.monster@sesame.tv")

# Use sub() to convert the email domains to datacamp.edu
sub(pattern="@.*\\.edu$",replace ="@datacamp.edu",emails)
```

```c
[1] "john.doe@datacamp.edu"    "education@world.gov"     
[3] "global@peace.org"         "invalid.edu"             
[5] "quant@datacamp.edu"       "cookie.monster@sesame.tv"
```

## Pattern help 

Regular expressions are a typical concept that you'll learn by doing and by seeing other examples. Before you rack your brains over the regular expression in this exercise, have a look at the new things that will be used:

.*: A usual suspect! It can be read as "any character that is matched zero or more times".
\\s: Match a space. The "s" is normally a character, escaping it (\\) makes it a metacharacter.
[0-9]+: Match the numbers 0 to 9, at least once (+).
([0-9]+): The parentheses are used to make parts of the matching string available to define the replacement. The \\1 in the replacement argument of sub() gets set to the string that is captured by the regular expression [0-9]+.
awards <- c("Won 1 Oscar.",
  "Won 1 Oscar. Another 9 wins & 24 nominations.",
  "1 win and 2 nominations.",
  "2 wins & 3 nominations.",
  "Nominated for 2 Golden Globes. 1 more win & 2 nominations.",
  "4 wins & 1 nomination.")

sub(".*\\s([0-9]+)\\snomination.*$", "\\1", awards)


Ans :A vector of character strings containing "Won 1 Oscar.", "24", "2", "3", "2", "1".

## Times & Dates

```r
# Get the current date: today
today <- Sys.Date()
# See what today looks like under the hood
unclass(today)
[1] 19390
# Get the current time: now
now <- Sys.time()
# See what now looks like under the hood
unclass(now)
[1] 1675353059
```


## Create and format dates
To create a Date object from a simple character string in R, you can use the as.Date() function. The character string has to obey a format that can be defined using a set of symbols (the examples correspond to 13 January, 1982):

%Y: 4-digit year (1982)
%y: 2-digit year (82)
%m: 2-digit month (01)
%d: 2-digit day of the month (13)
%A: weekday (Wednesday)
%a: abbreviated weekday (Wed)
%B: month (January)
%b: abbreviated month (Jan)
The following R commands will all create the same Date object for the 13th day in January of 1982:

```c
as.Date("1982-01-13")
as.Date("Jan-13-82", format = "%b-%d-%y")
as.Date("13 January, 1982", format = "%d %B, %Y")

```

Notice that the first line here did not need a format argument, because by default R matches your character string to the formats "%Y-%m-%d" or "%Y/%m/%d".

In addition to creating dates, you can also convert dates to character strings that use a different date notation. For this, you use the format() function. Try the following lines of code:

today <- Sys.Date()
format(Sys.Date(), format = "%d %B, %Y")
format(Sys.Date(), format = "Today is a %A!")

```r
# Definition of character strings representing dates
str1 <- "May 23, '96"
str2 <- "2012-03-15"
str3 <- "30/January/2006"

# Convert the strings to dates: date1, date2, date3
date1 <- as.Date(str1, format = "%b %d, '%y")
date2 <- as.Date(str2)
date3 <- as.Date(str3, format="%d/%B/%Y")


# Convert dates to formatted strings
format(date1, "%A")
format(date2, "%d")
format(date3, "%b %Y")
```

# Create and format times
Similar to working with dates, you can use as.POSIXct() to convert from a character string to a POSIXct object, and format() to convert from a POSIXct object to a character string. Again, you have a wide variety of symbols:

%H: hours as a decimal number (00-23)
%I: hours as a decimal number (01-12)
%M: minutes as a decimal number
%S: seconds as a decimal number
%T: shorthand notation for the typical format %H:%M:%S
%p: AM/PM indicator
For a full list of conversion symbols, consult the strptime documentation in the console:

?strptime
Again,as.POSIXct() uses a default format to match character strings. In this case, it's %Y-%m-%d %H:%M:%S. In this exercise, abstraction is made of different time zones.

```r
# Definition of character strings representing times
str1 <- "May 23, '96 hours:23 minutes:01 seconds:45"
str2 <- "2012-3-12 14:23:08"

# Convert the strings to POSIXct objects: time1, time2
time1 <- as.POSIXct(str1, format = "%B %d, '%y hours:%H minutes:%M seconds:%S")
time2 <- as.POSIXct(str2)

# Convert times to formatted strings
format(time1, "%M")
format(time2, "%I:%M %p")
```

## Calculations with Dates
Both Date and POSIXct R objects are represented by simple numerical values under the hood. This makes calculation with time and date objects very straightforward: R performs the calculations using the underlying numerical values, and then converts the result back to human-readable time information again.

You can increment and decrement Date objects, or do actual calculations with them:

today <- Sys.Date()
today + 1
today - 1

as.Date("2015-03-12") - as.Date("2015-02-27")
To control your eating habits, you decided to write down the dates of the last five days that you ate pizza. In the workspace, these dates are defined as five Date objects, day1 to day5. A vector pizza containing these 5 Date objects has been pre-defined for you.

```r
# day1, day2, day3, day4 and day5 are already available in the workspace
# Difference between last and first pizza day
day5 - day1
Time difference of 18 days
# Create vector pizza
pizza <- c(day1, day2, day3, day4, day5)
# Create differences between consecutive pizza days: day_diff
day_diff <- diff(pizza)
# Average period between two consecutive pizza days
mean(day_diff)
Time difference of 4.5 days
```

## Calculations with Times
Calculations using POSIXct objects are completely analogous to those using Date objects. Try to experiment with this code to increase or decrease POSIXct objects:

now <- Sys.time()
now + 3600          # add an hour
now - 3600 * 24     # subtract a day
Adding or subtracting time objects is also straightforward:

birth <- as.POSIXct("1879-03-14 14:37:23")
death <- as.POSIXct("1955-04-18 03:47:12")
einstein <- death - birth
einstein
You're developing a website that requires users to log in and out. You want to know what is the total and average amount of time a particular user spends on your website. This user has logged in 5 times and logged out 5 times as well. These times are gathered in the vectors login and logout, which are already defined in the workspace.

```r
# login and logout are already defined in the works
time_online = logout - login

# Inspect the variable time_online
print(time_online)

# Calculate the total time online
sum(time_online)

# Calculate the average time online
mean(time_online)
```


```r
# Convert astro to vector of Date objects: astro_dates
astro_dates <- as.Date(astro,"%d-%b-%Y")

# Convert meteo to vector of Date objects: meteo_dates
meteo_dates <- as.Date(meteo,"%B %d, %y")

# Calculate the maximum absolute difference between astro_dates and meteo_dates
max(abs(astro_dates- meteo_dates))

```
