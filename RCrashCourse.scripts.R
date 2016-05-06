############################
# A Crash-course in the R Programming Language
# Bill Petti (billpetti@gmail.com)
# GitHub: https://github.com/BillPetti
# May 2016
############################

#### What we will cover

# What is R?
# R fundamentals (data structures, functions, packages, etc.) 
# Getting data in and out of R
# Manipulating data (transposing, recoding, variable creation, etc.)
# Basic descriptive statistics (crosstabs, frequencies, grouped means, etc.)
# Basic statistics and modeling (correlation and linear regression)
# Plotting and data visualization (base and ggplot2)
# Additional Resources
# Acknowledgements

### What is R?

# R is an object oriented programming language focused on manipulating and analyzing data
# Everything in R is an object: e.g. datasets, functions, models, plots, etc.
 
# R is opensource
# Anyone can- contribute to the R project, and develop and distribute code to run on the R platform
 
# R has become one of the most popular languages used by statisticians and data scientists
# There is a massive community that contributes to R

### R Fundamentals
## Working Directory

# It's always good to check and see where R will be saving your files--that includes data from your current session and any objects that you export from R (we'll walk through that a little later)

# To see what the current working directory is set to:

getwd()

# Note use of forward slashes ("/" not "\")

# If you want to or need to change the default directory:

# setwd("<path of desired directory>")

## Assigning Objects

# Objects can be assigned by using the `<-` operator

foo <- "hello world!"
foo
# [1] "hello world!"

# Object names should begin with a letter and can contain letters, numbers, underscores, or periods

# Case matters

myvar <- c(1,2,3)
Myvar
# Error: object 'Myvar' not found

myvar
# [1] 1 2 3

## Comments

# Any text preceded by a `#` will be treated as a comment by R

# This is a comment
# foo2 <- “hello world!”

foo2
# Error: object ‘foo2’ not found

## Data Structures
# Vectors

# A vector in R is sequence of elements of the same type  
# They can be numeric 

x <- c(1,2,3,4,5)
x
# [1] 1 2 3 4 5 

# or character

firstNames <- c("Shinji", "Aska", "Rey", "Misato")
firstNames
# [1] "Shinji" "Aska"   "Rey"    "Misato"

# Once a vector is saved as an object (i.e. variable), you can access different parts of the vector by referencing its indexed position
# For examnple, if we want the third name in the firstNames vector we run:

firstNames[3]
# [1] "Rey"

# We can also explore the structure of a vector using the `str()` function:

str(firstNames)
# chr [1:4] "Shinji" "Aska" "Rey" "Misato"

# Factors
# Categorical variables in R are called "factors"
# Factors have as many levels as their are unique categories

# create a vector called 'gender'
gender <- c("f", "f", "f", "m", "m", "m", "m")
# transform 'gender' into a factor object
gender <- factor(gender)
# examine the structure of 'gender'
str(gender)
# [1] f f f m m m m
# Levels: f m

# Lists
# A list is a sequence of elements of different types

myList <- list(x=x, firstNames=firstNames, gender=gender)
myList
# $x
# [1] 1 2 3 4 5
# 
# $firstNames
# [1] "Shinji" "Aska"   "Rey"    "Misato"
# 
# $gender
# [1] f f f m m m m
# Levels: f m

# You can call specific elements within the list using the list index:

myList[[1]]
# [1] 1 2 3 4 5

# Or execute functions on specific elements:

str(myList[[2]])
# chr [1:4] "Shinji" "Aska" "Rey" "Misato"

# You can also reference individual elements from a list using `$`:

myList$x
# [1] 1 2 3 4 5

# Or the name of the element with double branches

str(myList[['firstNames']])
# chr [1:4] "Shinji" "Aska" "Rey" "Misato"

# Dataframes

# Dataframes are two dimensional objects##think rows and columns##basically, tables of data

# You can manually create dataframes by combining two vectors with the data.frame function

franchise <- c("Mets", "Nationals", "Marlins", "Phillies", "Braves")
city <- c("New York", "Washington, DC", "Miami", "Philadelphia", "Atlanta")
teams <- data.frame(franchise, city)
teams
# franchise           city
# 1      Mets       New York
# 2 Nationals Washington, DC
# 3   Marlins          Miami
# 4  Phillies   Philadelphia
# 5    Braves        Atlanta

# Dataframes are of class data.frame
# The names of the columns (or variables) are stored as attributes of the dataframe and can be called using `names()`:

names(teams)
# [1] "franchise" "city" 

# Matrix, Matrices

# A matrix is similar to a dataframe except that all of its values are numeric

## Functions

# A piece of code written to complete a specific, often repeated, task
# For example, if we wanted to find the mean of our `x` vector we could write the following code:

x
# [1] 1 2 3 4 5
(1+2+3+4+5)/5
# [1] 3

# But this is inefficient, especially with a vector of any real length and complexity

# So let's write a function for it!

# In R, functions consist of a function name and arguments. You feed the required arguments into the function and it returns a single value.

# Let's take the `combine` (or `c`) function that you've seen earlier, but I've failed to explain:

# combine the following elements into a vector: 1, 2, 3, 4, 5

x <- c(1, 2, 3, 4, 5)
x
# [1] 1 2 3 4 5

# In the example above, `c` is the function name and everything in parenteses `()` are its arguments

# Let's go back to our mean example. R does have a base function built in for calculating means, but let's build our own.

# To do this, we will make use of some other base R functions:`sum` and `length`

# `sum()` takes whatever values are passed to it in its arguments and sums them
# `length()` returns the length (or count) of values passed to it in its arguments

# So here's our version of a function for calculating the mean of a vector (and how you write a function, generally):

our.mean <- function(x){
  return(sum(x) / length(x))
}

# So our function's name is `our.mean`. It takes a vector or set of numbers as its arguments, sums those numbers and then divides that sum by the number of individual numbers returning the mean (average) of the set of numbers

# Let's try it!

# Here's the mean of our `x` vector using R's base `mean()` function:

x
# [1] 1 2 3 4 5
mean(x)
# [1] 3

# And here's the mean using the `our.mean()` function:

our.mean(x)
# [1] 3

# We can even double check that these values are equivalent

mean(x) == our.mean(x)
# [1] TRUE

# Let's take another look at that function we wrote:

our.mean <- function(x){
  return(sum(x) / length(x))
}

# The operations that should be applied are placed inside curly brackets `{}`
# Here we also used the `return` function to tell the function what should be returned to the environment after running
# There are other ways to make sure your result is returned to the environment

# Here are some additional examples:

our.mean <- function(x){
  foo <- sum(x) / length(x)
  print(foo)
}

# or 

our.mean <- function(x){
  foo <- sum(x) / length(x)
  foo
}

# Both return 3 when applied to vector `x`

# Functions can be very simple, like the `our.mean` function, or complex
# You can layer in numerous functions and temporary objects. For example, let's say we wanted to summarize a vector in terms of it's mean, median, and standard deviation:

our.summary <- function(x) {
  mean <- mean(x)
  median <- median(x)
  standard_deviation <- sd(x)
  foo <- cbind(mean, median, standard_deviation)
  return(foo)
}

our.summary(x)
# mean median standard_deviation
# [1,]    3      3           1.581139

# The function takes a vector and returns the three summary statistics we specified in the function. Notice that the function relies on other, pre-existing functions and only returns the outputs of those functions. It does not save the objects assigned inside the function to the global environment. Take a look in your Environment pane, or use the function below to see a list of objects currently in your Environment:

ls()
# [1] "city"        "firstNames"  "foo"         "franchise"   "gender"      "myList"      "myvar"       "our.mean"    "our.summary" "teams"      
# [11] "x"     

## Packages

# Packages are essentially collections of functions that can be installed and loaded when necessary
# Anyone can write and distrbute a package
# Greatly expand R's capabilities, and since they are open source R's functionality expands very quickly
# Allow for easy distribution and documentation of useful functions in all areas (data manipulation, modeling, visualiztion, web scraping, etc.)
# Packages are distributed through CRAN (https://cran.r-project.org/) or through other outlets, e.g. GitHub (https://github.com)

# Let's use the example of `reshape2` package
# `reshape2` contains very useful functions for transforming datasets, for example from wide to long format and vice#versa

# to install the reshape2 package from CRAN
install.packages("reshape2")

# Installing package into ‘C:/Users/bill_petti/Documents/R/win-library/3.2’
# (as ‘lib’ is unspecified)
# trying URL 'http://cran.rstudio.com/bin/windows/contrib/3.2/reshape2_1.4.1.zip'
# Content type 'application/zip' length 503646 bytes (491 KB)
# downloaded 491 KB
# 
# package ‘reshape2’ successfully unpacked and MD5 sums checked
# 
# The downloaded binary packages are in (some directory)
# once installed, you need to load the package to use the functions

library(reshape2)

# you can see which packages are loaded by using the `search` function:

search()

# [1] ".GlobalEnv"        "package:reshape2"  "tools:rstudio"     "package:stats"    
# [5] "package:graphics"  "package:grDevices" "package:utils"     "package:datasets" 
# [9] "package:methods"   "Autoloads"         "package:base"   

# you can also load packages using require()

# let's first unload reshape2

detach("package:reshape2")

# then use `require` and check to see if it loaded

require(reshape2)

search()

# [1] ".GlobalEnv"        "package:reshape2"  "tools:rstudio"     "package:stats"    
# [5] "package:graphics"  "package:grDevices" "package:utils"     "package:datasets" 
# [9] "package:methods"   "Autoloads"         "package:base"   

# Here are some of the packages I find most useful, day to day, some of which we will explore:

# `dplyr`: robust functions for manipulating and summarizing tabular data
# `reshape2`: functions for transforming datasets
# `ggplot2`: comprehensive data visualization functions
# `ggthemes`: add#on for `ggplot2`, providing custom graphic themes
# `rvest`: flexible web-scraping functions

# More on packages later, just remember they are awesome

### Getting data in and out of R

# There are several ways to get your data in and out of R
# Let's start with getting data in
# Base R includes a series of `read.` functions that can be used

# for csv files
# read.delim("file location", header = TRUE, sep = "\t", quote = "\"", dec = ".", fill = TRUE, comment.char = "", ...)

# for other delimited files
# read.delim("file location", header = TRUE, sep = "\t", quote = "\"", dec = ".", fill = TRUE, comment.char = "", ...)

# You can also read in data that is stored on a website using the url of the site as the file location

# this is a csv file stored in one of my GitHub repositories

dat <- read.csv("https://raw.githubusercontent.com/BillPetti/R-Crash-Course/master/FanGraphs_Leaderboard_Cum_WAR.csv", header = TRUE, na.strings="NA")

str(dat) # shows the structure of the object

# This is a good place to point out that, by default, R will read in any string variables as factors unless you tell it not to. If you look at the Name variable you can see that R has transformed it into a factor. In most cases you may not want that.
# You can avoid this behavior by using the `stringsAsFactors` command
# Let's try again

dat <- read.csv("https://raw.githubusercontent.com/BillPetti/R-Crash-Course/master/FanGraphs_Leaderboard_Cum_WAR.csv", header = TRUE, na.strings="NA", stringsAsFactors = FALSE)

str(dat)

head(dat) # shows the first 6 records or rows of the object

# It is also possible to import specific file types, like excel or spss
# For excel files, you can use the `xlsx` package  

# require(xlsx)
# df <- read.xlsx("<-name and extension of your file>", sheetIndex = 1)

# SPSS files can be loaded with the help of the `foreign` package  

# require(foreign)
# df <- read.spss("file", use.value.labels = TRUE, to.data.frame = TRUE)

# For SPSS files, if you want the value labels to be imported set the `use.value.labels` argument to `TRUE`; for the actual values, choose `FALSE`

# To export data, you simply use the `write.` series of functions

# export a dataframe as a csv file to your current working directory

write.csv(dat, "baseball_data.csv", row.names = FALSE)

# check your working directory for the file

# You can also export to a different directory if you need to:

# export a dataframe as a csv file to a different directory

write.csv(dat, "C:/Users/bill_petti/Documents/baseball_data.csv", row.names = FALSE)

# You can also export any object; for example, a summary table

summary.ex <- our.summary(x)
summary.ex
# mean median standard_deviation
# [1,]    3      3           1.581139
write.csv(summary.ex, "summary.ex.csv", row.names = FALSE)

# You can also clean up your work space by removing objects (datasets, functions, etc.) using the rm() function

# A good rule of thumb is to remove any vectors that you have merged into data frames. Let's remove the two vectors we used to ceate the `teams` data frame:

rm(city, franchise)
ls()
# [1] "dat"         "firstNames"  "foo"         "gender"      "myList"      "myvar"       "our.mean"    "our.summary" "summary.ex"  "teams"      
# [11] "x"    

# You'll notice that you can remove multiple objects at once by separating each with a comma. 

# You can remove all objects in your current environment by using the ls() function. This is a good idea when starting a new analysis to ensure you don't end up referencing objects with similar names from a previous analysis.

# rm(list=ls())  

### Manipulating data

# Let's walk through some common ways to manipulate data in R
# We can use some of the datasets included in the base version
# To see what's available, execute `data()`

data()

# Let's load the `iris` dataset and view the first 10 rows:

data(iris)
head(iris, 3)
# Sepal.Length Sepal.Width Petal.Length Petal.Width Species
# 1          5.1         3.5          1.4         0.2  setosa
# 2          4.9         3.0          1.4         0.2  setosa
# 3          4.7         3.2          1.3         0.2  setosa

# We can access individual variables in a dataset using the `$` notation
# for example, say you just wanted to view the Sepal.Length variable from the iris dataset. If you try to call it directory, it won't work:

head(Sepal.Length, 3)
# Error in head(Sepal.Length, 3) : object 'Sepal.Length' not found

# That's because Sepal.Length isn't a separate object--it only lives inside of the object iris.
# Now, here's how to access it using the `$` notation

head(iris$Sepal.Length, 3)
# [1] 5.1 4.9 4.7

# If you want to access more than one variabe at a time you can make your life easier by using the `with` function.

with(iris, head(Sepal.Length, 3))
# [1] 5.1 4.9 4.7

# The first argument in `with` is the data frame you want to reference, then you can identify individual variables simply by their name. 

# Here's an example using multiple variables from the iris dataset. Let's say we wanted to see the ratio of sepal length to width:

with(iris, Sepal.Length / Sepal.Width)
# [1] 1.457143 1.633333 1.468750 1.483871 1.388889 1.384615 1.352941 1.470588 1.517241 1.580645 1.459459 1.411765 1.600000 1.433333 1.450000
# [16] 1.295455 1.384615 1.457143 1.500000 1.342105 1.588235 1.378378 1.277778 1.545455 1.411765 1.666667 1.470588 1.485714 1.529412 1.468750
# [31] 1.548387 1.588235 1.268293 1.309524 1.580645 1.562500 1.571429 1.361111 1.466667 1.500000 1.428571 1.956522 1.375000 1.428571 1.342105
# [46] 1.600000 1.342105 1.437500 1.432432 1.515152 2.187500 2.000000 2.225806 2.391304 2.321429 2.035714 1.909091 2.041667 2.275862 1.925926
# [61] 2.500000 1.966667 2.727273 2.103448 1.931034 2.161290 1.866667 2.148148 2.818182 2.240000 1.843750 2.178571 2.520000 2.178571 2.206897
# [76] 2.200000 2.428571 2.233333 2.068966 2.192308 2.291667 2.291667 2.148148 2.222222 1.800000 1.764706 2.161290 2.739130 1.866667 2.200000
# [91] 2.115385 2.033333 2.230769 2.173913 2.074074 1.900000 1.965517 2.137931 2.040000 2.035714 1.909091 2.148148 2.366667 2.172414 2.166667
# [106] 2.533333 1.960000 2.517241 2.680000 2.000000 2.031250 2.370370 2.266667 2.280000 2.071429 2.000000 2.166667 2.026316 2.961538 2.727273
# [121] 2.156250 2.000000 2.750000 2.333333 2.030303 2.250000 2.214286 2.033333 2.285714 2.400000 2.642857 2.078947 2.285714 2.250000 2.346154
# [136] 2.566667 1.852941 2.064516 2.000000 2.225806 2.161290 2.225806 2.148148 2.125000 2.030303 2.233333 2.520000 2.166667 1.823529 1.966667

# What if we want the length/width ration to be a variable we can access in our dataset? 

# You can assign variables to datasets using the `$` notation

iris$sepal_length_width_ratio <- with(iris, Sepal.Length / Sepal.Width)
head(iris)

# Sepal.Length Sepal.Width Petal.Length Petal.Width Species sepal_length_width_ratio
# 1          5.1         3.5          1.4         0.2  setosa                1.457143
# 2          4.9         3.0          1.4         0.2  setosa                1.633333
# 3          4.7         3.2          1.3         0.2  setosa                1.468750
# 4          4.6         3.1          1.5         0.2  setosa                1.483871
# 5          5.0         3.6          1.4         0.2  setosa                1.388889
# 6          5.4         3.9          1.7         0.4  setosa                1.384615

# If you need to, you can also round values with the `round` function

iris$sepal_length_width_ratio <- round(iris$sepal_length_width_ratio, 2)
head(iris)
# Sepal.Length Sepal.Width Petal.Length Petal.Width Species sepal_length_width_ratio
# 1          5.1         3.5          1.4         0.2  setosa                    1.46
# 2          4.9         3.0          1.4         0.2  setosa                    1.63
# 3          4.7         3.2          1.3         0.2  setosa                    1.47
# 4          4.6         3.1          1.5         0.2  setosa                    1.48
# 5          5.0         3.6          1.4         0.2  setosa                    1.39
# 6          5.4         3.9          1.7         0.4  setosa                    1.38

# You can also recode variable using the `ifelse` function
# Let's code each case based on whether they are below, between, or above the 1st and 3rd quartile for sepal_length_width_ratio 
# You can get a quick summary of any variable with `summary`

summary(iris$sepal_length_width_ratio)
# Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
# 1.270   1.550   2.030   1.954   2.228   2.960 

iris$ratio_q <- with(iris, ifelse(sepal_length_width_ratio <= 1.550, 1, ifelse(sepal_length_width_ratio > 1.550 & sepal_length_width_ratio < 2.228, 2, ifelse(sepal_length_width_ratio >= 2.228, 3, NA))))
head(iris[,c(6:7)], 10)
# sepal_length_width_ratio ratio_q
# 1                      1.46       1
# 2                      1.63       2
# 3                      1.47       1
# 4                      1.48       1
# 5                      1.39       1
# 6                      1.38       1
# 7                      1.35       1
# 8                      1.47       1
# 9                      1.52       1
# 10                     1.58       2

## Subsetting Data

# There are many ways to subset data in R

# Base R includes the `subset` function

# There are three unique species in the iris dataset. We can see unique values for any variable using the `unique` function:

unique(iris$Species)
# [1] setosa     versicolor virginica 
# Levels: setosa versicolor virginica

# Let's say we wanted to subset iris and just include cases where the species is virginica

sub_virginica <- subset(iris, Species == "virginica")
head(sub_virginica)
# Sepal.Length Sepal.Width Petal.Length Petal.Width   Species sepal_length_widt_ratio
# 101          6.3         3.3          6.0         2.5 virginica                    1.91
# 102          5.8         2.7          5.1         1.9 virginica                    2.15
# 103          7.1         3.0          5.9         2.1 virginica                    2.37
# 104          6.3         2.9          5.6         1.8 virginica                    2.17
# 105          6.5         3.0          5.8         2.2 virginica                    2.17
# 106          7.6         3.0          6.6         2.1 virginica                    2.53

unique(sub_virginica$Species)
# [1] virginica

# Notice that in R the logical comparison for equals is `==`

# We could also simply exclude all cases where Species == "virginica"

ex_virginica <- subset(iris, Species != "virginica")
unique(ex_virginica$Species)
# [1] setosa     versicolor

# We may also want to include more than one condition for the subset. 

# Let's subset only those cases where Species == "virginica" and the legnth/width ratio is greater than 2

sub_virginica2 <- subset(iris, Species != "virginica" & sepal_length_width_ratio >= 2)
head(sub_virginica2)
# Sepal.Length Sepal.Width Petal.Length Petal.Width    Species sepal_length_widt_ratio
# 51          7.0         3.2          4.7         1.4 versicolor                    2.19
# 52          6.4         3.2          4.5         1.5 versicolor                    2.00
# 53          6.9         3.1          4.9         1.5 versicolor                    2.23
# 54          5.5         2.3          4.0         1.3 versicolor                    2.39
# 55          6.5         2.8          4.6         1.5 versicolor                    2.32
# 56          5.7         2.8          4.5         1.3 versicolor                    2.04

# You can also select specific variables using the index approach

head(iris[,c(1,3)])
# Sepal.Length Petal.Length
# 1          5.1          1.4
# 2          4.9          1.4
# 3          4.7          1.3
# 4          4.6          1.5
# 5          5.0          1.4
# 6          5.4          1.7

# This returns just the first and third variables in the iris dataset

# You can also select specific cases using the same approach

iris[c(1:6),]
# Sepal.Length Sepal.Width Petal.Length Petal.Width Species sepal_length_widt_ratio
# 1          5.1         3.5          1.4         0.2  setosa                    1.46
# 2          4.9         3.0          1.4         0.2  setosa                    1.63
# 3          4.7         3.2          1.3         0.2  setosa                    1.47
# 4          4.6         3.1          1.5         0.2  setosa                    1.48
# 5          5.0         3.6          1.4         0.2  setosa                    1.39
# 6          5.4         3.9          1.7         0.4  setosa                    1.38

# This will return all variables in the dataset, but only rows one through six

## The dplyr package

# While you can get very far with the base functions in R, I find the dplyr function to be a go-to tool for data manipulation

# dplyr was developed and is maintained by Hadley Wickham, who is currently the Chief Scientist at RStudio and has produced a number of the most prolific and useful R packages

# Much of the material that follows is borrowed from the in-depth vignette found at: https://cran.rstudio.com/web/packages/dplyr/vignettes/introduction.html

# Let's install and load it. This syntax below simply says that if R can't load dplyr then install it first

if (!require(dplyr)) {
  install.packages(dplyr)
}

# To demonstratae the functionality of the dplyr package I've created a trimmed down version of the Lahman database, which is a publically available dataset of various baseball statistics.

# To make life easier, there are two files (or tables) to import: lahman_reduced_batting and lahman_player

batting <- read.csv("https://raw.githubusercontent.com/BillPetti/R-Crash-Course/master/batting_1950.csv", header = TRUE, stringsAsFactors = FALSE)

player <- read.csv("https://raw.githubusercontent.com/BillPetti/R-Crash-Course/master/player.csv", header = TRUE, stringsAsFactors = FALSE)

# We can start by doing some basic subsetting using dplyr. You will see in many ways it is quite similar to some of the base R functionality.

# We can filter for cases where a player had at least 600 at bats in a season

AB_400 <- filter(batting, AB >= 400)

# We could also reduce the number of variables by using the select function

AB_400_reduced <- select(AB_400, playerID, yearID, G, AB, HR)

# Dplyr also allows you to create new variables using the `mutate` function

AB_400 <- mutate(AB_400, AB_per_HR = AB/HR)
head(AB_400$AB_per_HR)
# [1] 80.60000 160.75000  54.20000 280.00000  37.50000  20.25926

# You can use the `arrange` function to sort a data frame by a specific variable

AB_400 <- arrange(AB_400, desc(HR))
head(AB_400$HR)
# [1] 73 70 66 65 64 63

# dplyr also makes merging and joining differen datasets extremely easy.

# Looking at the batting table you'll notice that their is a playerID variable, but not the player's actual name. That information is in the player table. Let's look at the variables from that table:

str(player)

# This table contains tons of biographical data about every player in the Lahman database
# We can join the AB_400 table with this table, which will include the first and last name of each player among other variables
# we can use a left join, which keeps all the cases from the first table and only matches in data from the second where there are common cases. playerID will be our key variable

AB_400_names <- left_join(AB_400, player, by = "playerID")

# now that the players' names are in the same dataset, let's create a variable with both their first and last names

AB_400_names$fullName <- with(AB_400_names, paste(nameFirst, nameLast))
head(AB_400_names$fullName)
# [1] "Barry Bonds"  "Mark McGwire" "Sammy Sosa"   "Mark McGwire" "Sammy Sosa"   "Sammy Sosa" 

# with dplyr, you can perform all standard types of joins, as well as use multiple criteria for the joins
# the variables you use for the join also do not need to have the same name.
# Let's remove the object we just created, change the name of the matching variable in the player object, and rejoin

rm(AB_400_names)
names(player)[names(player) == "playerID"] <- "ID_number"
str(player)

AB_400_names <- left_join(AB_400, player, by = c("playerID" = "ID_number"))
AB_400_names$fullName <- with(AB_400_names, paste(nameFirst, nameLast))
head(AB_400_names$fullName)
# [1] "Barry Bonds"  "Mark McGwire" "Sammy Sosa"   "Mark McGwire" "Sammy Sosa"   "Sammy Sosa"  

# This is nice, but we probably want the player name as the first column
# There are a few ways to rearrange column order in R
# Here are a few examples
# Let's move fullName to the first column using the index approach

AB_400_names_index <- AB_400_names[,c(49, 1:48)]
head(AB_400_names_index[,c(1:6)])
# fullName  playerID yearID stint teamID lgID
# 1  Barry Bonds bondsba01   2001     1    SFN   NL
# 2 Mark McGwire mcgwima01   1998     1    SLN   NL
# 3   Sammy Sosa  sosasa01   1998     1    CHN   NL
# 4 Mark McGwire mcgwima01   1999     1    SLN   NL
# 5   Sammy Sosa  sosasa01   2001     1    CHN   NL
# 6   Sammy Sosa  sosasa01   1999     1    CHN   NL
rm(AB_400_names_index)

# We can also use the select function from dplyr

AB_400_names_index <- select(AB_400_names, fullName, everything())
head(AB_400_names_index[,c(1:6)])
# fullName  playerID yearID stint teamID lgID
# 1  Barry Bonds bondsba01   2001     1    SFN   NL
# 2 Mark McGwire mcgwima01   1998     1    SLN   NL
# 3   Sammy Sosa  sosasa01   1998     1    CHN   NL
# 4 Mark McGwire mcgwima01   1999     1    SLN   NL
# 5   Sammy Sosa  sosasa01   2001     1    CHN   NL
# 6   Sammy Sosa  sosasa01   1999     1    CHN   NL

# Notice the use of `everything()`. This allows you to order whatever columns you want by name and then have the rest of the columns remain in their current order.

rm(AB_400_names_index)

# The magic if piping
# So far we have focused on discrete lines of code. In many cases you need to combine many lines of code to achieve some objective.
# But this can be inefficient, introduces more opportunity for error, and can make the code less readable--as well as increasing the number of objects in your environment.
# Entering the pipe function, or `%>%`
# `%>%` basically means `then`. Do whatever operation is on the left side of the `%>%`, then do whatever is one the right using the data from the left
# Here is a basic example
# Creat an object that only contains players whose height was less than 5'10" (or 70 inches) and then select only fullName, yearID, and HR

AB_400_names_reduced <- filter(AB_400_names, height < 70) %>% 
  select(fullName, yearID, HR)

head(AB_400_names_reduced)
# fullName yearID HR
# 1 Roy Campanella   1953 41
# 2    Matt Stairs   1999 38
# 3 Ivan Rodriguez   1999 35
# 4  Miguel Tejada   2002 34
# 5  Miguel Tejada   2004 34
# 6 Roy Campanella   1951 33

# You can also expand on this as much as you want. Let's also arrange the data by HR in ascending order


AB_400_names_reduced <- filter(AB_400_names, height < 70) %>% 
  select(fullName, yearID, HR) %>%
  arrange(HR)

head(AB_400_names_reduced)
# fullName yearID HR
# 1    Spook Jacobs   1954  0
# 2 Sparky Anderson   1959  0
# 3   Sonny Jackson   1967  0
# 4      Matty Alou   1968  0
# 5 Cesar Gutierrez   1970  0
# 6  Enzo Hernandez   1971  0

## Reshape Data

# Sometimes you need to change the orientation of your dataset. Some datasets are long--few columns, many rows; some datasets are wide--many columns, few rows.

# The `reshape2` packge makes these kinds of transformations very easy

# Let's use the built in `airquality` dataset in R

head(airquality)
str(airquality)
# 'data.frame':  153 obs. of  6 variables:
#   $ Ozone  : int  41 36 12 18 NA 28 23 19 8 NA ...
# $ Solar.R: int  190 118 149 313 NA NA 299 99 19 194 ...
# $ Wind   : num  7.4 8 12.6 11.5 14.3 14.9 8.6 13.8 20.1 8.6 ...
# $ Temp   : int  67 72 74 62 56 66 65 59 61 69 ...
# $ Month  : int  5 5 5 5 5 5 5 5 5 5 ...
# $ Day    : int  1 2 3 4 5 6 7 8 9 10 ...

# let's create a long dataset from airquality

long <- melt(airquality)
str(long)
# 'data.frame':	918 obs. of  2 variables:
#   $ variable: Factor w/ 6 levels "Ozone","Solar.R",..: 1 1 1 1 1 1 1 1 1 1 ...
# $ value   : num  41 36 12 18 NA 28 23 19 8 NA ...

head(long)
# variable value
# 1    Ozone    41
# 2    Ozone    36
# 3    Ozone    12
# 4    Ozone    18
# 5    Ozone    NA
# 6    Ozone    28

summary(long)
# variable       value       
# Ozone  :153   Min.   :  1.00  
# Solar.R:153   1st Qu.:  8.00  
# Wind   :153   Median : 19.50  
# Temp   :153   Mean   : 56.02  
# Month  :153   3rd Qu.: 78.00  
# Day    :153   Max.   :334.00  
# NA's   :44 

# We have melted the dataset, creating one column that includes each column from the original dataset, and another column that contains each value of the previous variables for each case

# We went from 153 cases with 6 variables to 918 cases with 2 variables

# We can also customize what variables to keep in the melted data. Let's keep the month and day

long <- melt(airquality, id.vars = c("Month", "Day"))
str(long)
head(long)
# Month Day variable value
# 1     5   1    Ozone    41
# 2     5   2    Ozone    36
# 3     5   3    Ozone    12
# 4     5   4    Ozone    18
# 5     5   5    Ozone    NA
# 6     5   6    Ozone    28

# Now the data is melted, but we have multiple rows for each Month and Day combination--one for each variable

# We can transform the long dataset back to wide using the `dcast` function

wide <- dcast(long, Month + Day ~ variable, value.var = c("value"))
head(wide)
# Month Day Ozone Solar.R Wind Temp
# 1     5   1    41     190  7.4   67
# 2     5   2    36     118  8.0   72
# 3     5   3    12     149 12.6   74
# 4     5   4    18     313 11.5   62
# 5     5   5    NA      NA 14.3   56
# 6     5   6    28      NA 14.9   66

head(airquality)
# Ozone Solar.R Wind Temp Month Day
# 1    41     190  7.4   67     5   1
# 2    36     118  8.0   72     5   2
# 3    12     149 12.6   74     5   3
# 4    18     313 11.5   62     5   4
# 5    NA      NA 14.3   56     5   5
# 6    28      NA 14.9   66     5   6

# When we compare the wide dataset to the original airquality dataset the only difference is the order of the variables

# We can also cast long datasets and apply aggregating functions to them. 
# Let's say we want to get the mean for each measure by month in the long dataset

mean_by_month <- dcast(long, Month ~ variable, value.var = c("value"), fun.aggregate = mean, na.rm = TRUE)
mean_by_month
# Month    Ozone  Solar.R      Wind     Temp
# 1     5 23.61538 181.2963 11.622581 65.54839
# 2     6 29.44444 190.1667 10.266667 79.10000
# 3     7 59.11538 216.4839  8.941935 83.90323
# 4     8 59.96154 171.8571  8.793548 83.96774
# 5     9 31.44828 167.4333 10.180000 76.90000

# There are easier ways to quickly aggregate variables in a dataset than melting, casting, and re-melting though.
# Which brings us to descriptive and summary statistics

### Basic descriptive and summary statistics

# The most basic way to get a summary of the data in an object is through the `summary` function

summary(airquality)
# Ozone           Solar.R           Wind             Temp           Month            Day      
# Min.   :  1.00   Min.   :  7.0   Min.   : 1.700   Min.   :56.00   Min.   :5.000   Min.   : 1.0  
# 1st Qu.: 18.00   1st Qu.:115.8   1st Qu.: 7.400   1st Qu.:72.00   1st Qu.:6.000   1st Qu.: 8.0  
# Median : 31.50   Median :205.0   Median : 9.700   Median :79.00   Median :7.000   Median :16.0  
# Mean   : 42.13   Mean   :185.9   Mean   : 9.958   Mean   :77.88   Mean   :6.993   Mean   :15.8  
# 3rd Qu.: 63.25   3rd Qu.:258.8   3rd Qu.:11.500   3rd Qu.:85.00   3rd Qu.:8.000   3rd Qu.:23.0  
# Max.   :168.00   Max.   :334.0   Max.   :20.700   Max.   :97.00   Max.   :9.000   Max.   :31.0  
# NA's   :37       NA's   :7        

# This gives us the minimum and maximum values for each variable, the 1st and 3rd quartiles, mean, median, and the number of missing values

# But we can do better than this, obviously

# Let's say we want to get other measures, like standard deviation, for each of the variables
# We can use dplyr's `summarise_each` function

summarise_each(airquality, funs(sd(., na.rm = TRUE)))
# Ozone  Solar.R     Wind    Temp    Month     Day
# 1 32.98788 90.05842 3.523001 9.46527 1.416522 8.86452

# the `.` represents where the table should go for a given function

# What if we want to get the standard deviation for each variable for each month? dplyr's group_by function makes this very simple
# We can first remove the Day column using `select`, since we really don't want the standard deviation for the day of the month

select(airquality, -Day) %>% group_by(Month) %>% summarise_each(funs(sd(., na.rm = TRUE)))
# Month    Ozone   Solar.R     Wind     Temp
# (int)    (dbl)     (dbl)    (dbl)    (dbl)
# 1     5 22.22445 115.07550 3.531450 6.854870
# 2     6 18.20790  92.88298 3.769234 6.598589
# 3     7 31.63584  80.56834 3.035981 4.315513
# 4     8 39.68121  76.83494 3.225930 6.585256
# 5     9 24.14182  79.11828 3.461254 8.355671

# Or, we can find the mean by month. You will see that the results are identical to what we saw after melting our data with the reshape2 package

select(airquality, -Day) %>% group_by(Month) %>% summarise_each(funs(mean(., na.rm = TRUE)))
# Month    Ozone  Solar.R      Wind     Temp
# (int)    (dbl)    (dbl)     (dbl)    (dbl)
# 1     5 23.61538 181.2963 11.622581 65.54839
# 2     6 29.44444 190.1667 10.266667 79.10000
# 3     7 59.11538 216.4839  8.941935 83.90323
# 4     8 59.96154 171.8571  8.793548 83.96774
# 5     9 31.44828 167.4333 10.180000 76.90000

# Another approach would be if the data were melted and you grouped by Month and then the questions

airquality_melt <- melt(airquality, id.vars = "Month") %>% filter(variable != "Day")
airquality_melt %>% group_by(Month, variable) %>% summarise(mean = mean(value, na.rm = TRUE))

# Month variable       mean
# (int)   (fctr)      (dbl)
# 1      5    Ozone  23.615385
# 2      5  Solar.R 181.296296
# 3      5     Wind  11.622581
# 4      5     Temp  65.548387
# 5      6    Ozone  29.444444
# 6      6  Solar.R 190.166667
# 7      6     Wind  10.266667
# 8      6     Temp  79.100000
# 9      7    Ozone  59.115385
# 10     7  Solar.R 216.483871
# 11     7     Wind   8.941935
# 12     7     Temp  83.903226
# 13     8    Ozone  59.961538
# 14     8  Solar.R 171.857143
# 15     8     Wind   8.793548
# 16     8     Temp  83.967742
# 17     9    Ozone  31.448276
# 18     9  Solar.R 167.433333
# 19     9     Wind  10.180000
# 20     9     Temp  76.900000

# Cross tabulation is also pretty easy in R

# You can run a simple crosstabulation using the `table` function. Let's cross Species by Petal.Width from the iris dataset

with(iris, table(Species, Petal.Width))

#             Petal.Width
# Species      0.1 0.2 0.3 0.4 0.5 0.6  1 1.1 1.2 1.3 1.4 1.5 1.6 1.7 1.8 1.9  2 2.1 2.2 2.3 2.4 2.5
#   setosa       5  29   7   7   1   1  0   0   0   0   0   0   0   0   0   0  0   0   0   0   0   0
#   versicolor   0   0   0   0   0   0  7   3   5  13   7  10   3   1   1   0  0   0   0   0   0   0
#   virginica    0   0   0   0   0   0  0   0   0   0   1   2   1   1  11   5  6   6   3   8   3   3

# We rarely want counts. We can get row or column frequencies by feeding the table result into the prop.table function

# If you don't specific a margin value it will return the proportion of each cross for the entire dataset. For row frequencies, use margin = 1. For column frequencies, use margin = 2.

with(iris, table(Species, Petal.Width)) %>% prop.table() %>% round(., 2)
#              Petal.Width
# Species       0.1  0.2  0.3  0.4  0.5  0.6    1  1.1  1.2  1.3  1.4  1.5  1.6  1.7  1.8  1.9    2  2.1  2.2  2.3  2.4  2.5
#   setosa     0.03 0.19 0.05 0.05 0.01 0.01 0.00 0.00 0.00 0.00 0.00 0.00 0.00 0.00 0.00 0.00 0.00 0.00 0.00 0.00 0.00 0.00
#   versicolor 0.00 0.00 0.00 0.00 0.00 0.00 0.05 0.02 0.03 0.09 0.05 0.07 0.02 0.01 0.01 0.00 0.00 0.00 0.00 0.00 0.00 0.00
#   virginica  0.00 0.00 0.00 0.00 0.00 0.00 0.00 0.00 0.00 0.00 0.01 0.01 0.01 0.01 0.07 0.03 0.04 0.04 0.02 0.05 0.02 0.02

with(iris, table(Species, Petal.Width)) %>% prop.table(margin = 1) %>% round(., 2)
#              Petal.Width
# Species       0.1  0.2  0.3  0.4  0.5  0.6    1  1.1  1.2  1.3  1.4  1.5  1.6  1.7  1.8  1.9    2  2.1  2.2  2.3  2.4  2.5
#   setosa     0.10 0.58 0.14 0.14 0.02 0.02 0.00 0.00 0.00 0.00 0.00 0.00 0.00 0.00 0.00 0.00 0.00 0.00 0.00 0.00 0.00 0.00
#   versicolor 0.00 0.00 0.00 0.00 0.00 0.00 0.14 0.06 0.10 0.26 0.14 0.20 0.06 0.02 0.02 0.00 0.00 0.00 0.00 0.00 0.00 0.00
#   virginica  0.00 0.00 0.00 0.00 0.00 0.00 0.00 0.00 0.00 0.00 0.02 0.04 0.02 0.02 0.22 0.10 0.12 0.12 0.06 0.16 0.06 0.06

with(iris, table(Species, Petal.Width)) %>% prop.table(margin = 2) %>% round(., 2)
#              Petal.Width
# Species       0.1  0.2  0.3  0.4  0.5  0.6    1  1.1  1.2  1.3  1.4  1.5  1.6  1.7  1.8  1.9    2  2.1  2.2  2.3  2.4  2.5
#   setosa     1.00 1.00 1.00 1.00 1.00 1.00 0.00 0.00 0.00 0.00 0.00 0.00 0.00 0.00 0.00 0.00 0.00 0.00 0.00 0.00 0.00 0.00
#   versicolor 0.00 0.00 0.00 0.00 0.00 0.00 1.00 1.00 1.00 1.00 0.88 0.83 0.75 0.50 0.08 0.00 0.00 0.00 0.00 0.00 0.00 0.00
#   virginica  0.00 0.00 0.00 0.00 0.00 0.00 0.00 0.00 0.00 0.00 0.12 0.17 0.25 0.50 0.92 1.00 1.00 1.00 1.00 1.00 1.00 1.00

# It is much easier to view and export crosstabs if you transform them using as.data.frame.matrix

cross_column_ex <- with(iris, table(Species, Petal.Width)) %>% prop.table(margin = 2) %>% round(., 2) %>% as.data.frame.matrix()
write.csv(cross_column_ex, "cross_column.csv")

### Basic statistics and modeling

# Let's use some sample survey data

survey_data <- read.csv("https://raw.githubusercontent.com/BillPetti/R-Crash-Course/master/survey_sample_data.csv", header = TRUE, stringsAsFactors = FALSE)
str(survey_data)

# there are 116 respondents and 18 questions. The questions are on a 5-point Likert scale, from Strongly Disagree to Strongly Agree

## Correlation

# the base function `cor` can be used to find basic correlations between variables. You must specific how `cor` should handle missing values. The use argument can take several meanings (see ?cor for more), but here we will use pairwise.

with(survey_data, cor(Q1, Q2, use = "pairwise.complete.obs"))

# We have 18 variables, so if we want to get a bird's eye view of how the variables relate to each other we can create a correlation grid.

survey_data_correlations <- cor(survey_data, use = "pairwise.complete.obs")
View(survey_data_correlations)

# but we don't really want to have the respondent column included, so we can exclude and re-run.

survey_data_correlations <- select(survey_data, -resp) %>% cor(use = "pairwise.complete.obs")
View(survey_data_correlations)

# to make it easier to read, we can round each correlation

survey_data_correlations <- round(survey_data_correlations, 3)
View(survey_data_correlations)

# Let's assume that we are very interested in the strength of the correlation between Q5 and Q2. Q18 also has a very strong correlation to Q2 (.587) and to Q5 (.743). We can run a partial correlation to better understand the strength and direction of the relationship between Q5 and Q2 after controlling for Q18. 

# Let's install and load the `ppcor` package 

if(!require("ppcor")){
  install.packages("ppcor")
  library(ppcor)
}

dplyr::select(survey_data, Q5, Q2, Q18) %>% filter(complete.cases(.)) %>% with(., pcor.test(Q2, Q5, Q18))

# estimate      p.value statistic   n gp  Method
# 1 0.4557204 3.934981e-07  5.393988 114  1 pearson

# So, after controlling for Q18 the correlation between Q2 and Q5 drops from .687 to .456. What if we controlled for all of the additional variables?

survey_data %>% filter(complete.cases(.)) %>% with(., pcor.test(Q2, Q5, .[,c(2, 4, 5, 7:19)]))

# estimate     p.value statistic   n gp  Method
# 1 0.2991328 0.003070371  3.039368 112 16 pearson

## ANOVA

# R also has built in functionality for ANOVA

# Let's randomly assign our respondents to 1 of 3 groups. `set.seed` allows you to replicate the same values when using `sample` or any other function that randomly generates numbers.

set.seed(42)
survey_data$group <- sample(1:3, 116, replace = TRUE)
with(survey_data, table(group))

# group
# 1  2  3 
# 33 38 45 

# First, we check if there are differences between the groups and their response to Q2

q2_anova <- aov(Q2 ~ as.factor(group), survey_data)
summary(q2_anova)

#                     Df Sum Sq Mean Sq F value Pr(>F)
# as.factor(group)   2   0.90  0.4502   0.559  0.573
# Residuals        113  90.99  0.8052 

# The p-value is quite high, so the groups are not different

# however, if they p-value was significant we could use the Tukey Honest Significance Difference method to see which pairs differef from each other

TukeyHSD(q2_anova, conf.level = .95)

# Tukey multiple comparisons of means
# 95% family-wise confidence level
# 
# Fit: aov(formula = Q2 ~ as.factor(group), data = survey_data)
# 
# $`as.factor(group)`
#             diff        lwr       upr     p adj
# 2-1 -0.19856459 -0.7056654 0.3085363 0.6225370
# 3-1 -0.02020202 -0.5086272 0.4682231 0.9946943
# 3-2  0.17836257 -0.2911583 0.6478835 0.6400294

# Obvioulsy, none of the pairs will show as significant, but you can see what the output will look like for future analyses

# We could also have plotted the means and their confidence intervals and checked for overlaps (we are skipping ahead a bit to plotting, but oh well...)

group_means <- dplyr::select(survey_data, Q2, group) %>% filter(complete.cases(.)) %>% group_by(group) %>% summarise(mean = mean(Q2), sd = sd(Q2), Length = NROW(Q2), q2frac = qnorm(.975), Lower = mean - q2frac*sd/sqrt(Length), Upper = mean + q2frac*sd/sqrt(Length))

if(!require("ggplot2")){
  install.packages("ggplot2")
  require(ggplot2)
}

ggplot(group_means, aes(x=mean, y=as.factor(group))) + geom_point() + geom_errorbarh(aes(xmin=Lower, xmax=Upper), height = .3)

## Linear Regression

# R has built-in functionality for running linear regressions witht the simple `lm` function
# Let's download some new data and see what does a better job predicting the rate at which a pitcher will give up runs in the following season (ERA)

era <- read.csv("https://raw.githubusercontent.com/BillPetti/R-Crash-Course/master/pitchers150IP.csv", header = TRUE, stringsAsFactors = FALSE)

# ERA_YR2 is our variable; it is a pitcher's ERA in the following season

# First, let's trim the data and take a look at a correlation grid

era_yr2 <- era[,-c(1:2, 16)]
era_yr2_cor <- as.data.frame(cor(era_yr2))
data.frame(Metric = row.names(era_yr2_cor), ERA_YR2 = round(era_yr2_cor$ERA_YR2, 3)) %>% mutate(Rsquared = round(ERA_YR2^2,3)) %>% arrange(desc(Rsquared))

era_lm <- lm(ERA_YR2 ~ ., data = era[,-c(1:2, 16)])
summary(era_lm)

# You can also limit the predictor variables in the model by adding them to the model formula

era_yr2_lm <- lm(ERA_YR2 ~ AVG + HR_9 + K_perc + K_minus_BB_perc, data = era_yr2)
summary(era_yr2_lm)

# Let's visualize the coefficients, which can be done with the `coefplot` package (it might require reinstaling ggplot2)

if(!require("coefplot")){
  install.packages("coefplot")
  require(coefplot)
}

coefplot(era_yr2_lm)
# thick line is +/- one standard error, thin line is +/- two standard errors

# You can call specific parts of the model output directly

era_yr2_lm$coefficients
# (Intercept)             AVG            HR_9          K_perc K_minus_BB_perc 
# 3.1760902       3.8148715       0.3696733      -0.2519514      -5.3470963 

# The r and adjusted r squared needs to be called from the summary() of the model

summary(era_yr2_lm)$adj.r.squared
# [1] 0.1930517

# And you can apply the model to actual data using `predict`
era_yr2_lm_predict <- predict(era_yr2_lm, era_yr2)
head(era_yr2_lm_predict)

# or, if you aren't applying to a new model you can just call the fit values from the model itself
fit <- era_yr2_lm$fitted.values
head(fit)

# We can calculate the accuracy of the model in terms of Mean Absolute Error (MAE) and Mean Absolute Percentage Error (MAPE)

compare <- data.frame(actual = era_yr2$ERA_YR2, predicted = fit)
compare$diff <- with(compare, predicted - actual)
MAE <- with(compare, mean(abs(diff)))
MAE
# [1] 0.5687383

MAPE <- with(compare, mean(abs(diff))/mean(actual))
MAPE
# [1] 0.1521268

# How does this compare to just using ERA in Time1 to predict ERA in Time2?

with(era_yr2, mean(abs(ERA - ERA_YR2)))
# [1] 0.6950591

with(era_yr2, mean(abs(ERA - ERA_YR2))/mean(ERA_YR2))
# [1] 0.1859152

# So our model increases the accuracy of just using ERA alone by about 18%
round((0.1521268-.1859152)/.1859152,2)
# [1] -0.18

### Plotting and data visualization

## Base Plotting

# histograms

hist(survey_data$Q2)

# You can directly edit the breaks to be used

hist(survey_data$Q2, main = "Frequency of Responses to Q2", xlab = "Response Value", breaks = c(0.0, 1.0, 2.0, 3.0, 4.0, 5.0))

# You can also extract the values instead of the histogram

hist(survey_data$Q2, breaks = c(0.0, 1.0, 2.0, 3.0, 4.0, 5.0), plot = FALSE)

# $breaks
# [1] 0 1 2 3 4 5
# 
# $counts
# [1]  1  9 24 56 26
# 
# $density
# [1] 0.00862069 0.07758621 0.20689655 0.48275862 0.22413793
# 
# $mids
# [1] 0.5 1.5 2.5 3.5 4.5
# 
# $xname
# [1] "survey_data$Q2"
# 
# $equidist
# [1] TRUE
# 
# attr(,"class")
# [1] "histogram"

# compare the $counts with a simple cross tab of Q2

table(survey_data$Q2)
# 1  2  3  4  5 
# 1  9 24 56 26 

# You can also show the density and not the counts for each bin

hist(survey_data$Q2, main = "Frequency of Responses to Q2", xlab = "Response Value", breaks = c(0.0, 1.0, 2.0, 3.0, 4.0, 5.0), freq = FALSE, labels = TRUE)

# You can further customize a `hist` through a variety of arguments. See ?hist for an accounting of the additional arguments

# basic plots

# scatter plots are also quite easy

plot(ERA ~ ERA_YR2, data = era_yr2, main = "ERA, Year 1 to Year 2", xlab = "ERA YR1", ylab = "ERA YR2")

# as are box plots

boxplot(era_yr2$ERA, main = "ERA", ylab = "ERA")

## ggplot2

# R has pretty good base plotting options, but the beauty of R is the ggplot2 packge from Hadley Wickham

# With ggplot2, you are basically building the visual in layers. Plots can be saved as objects and then additional layers added on

# Let's start with a basic scatterplot and use data from the `diamonds` data set

ggplot(diamonds, aes(x = carat, y = price)) + geom_point()

# Let's save the base of the plot as an object and then add additional layers one by one

p <- ggplot(diamonds, aes(x = carat, y = price))
p

# we can color code each point by the $color variable in the dataset

p + geom_point(aes(color = color))

# We could also adjust the size of each point by the $depth variable

p + geom_point(aes(color = color, size = depth))

# This is a bit hard to make it, so let's add some transparency to each point using the alpha argument

p + geom_point(aes(color = color, size = depth, alpha = .3))

# This still looks pretty messy, so let's create separate plots to compare broken out by color. To do this, we can use the facet argument

p + geom_point(aes(color = color)) + facet_wrap(~color)

# facets can also work with two dimensions, and we can place the facets in a grid pattern

p + geom_point(aes(color = color)) + facet_grid(cut ~ clarity)

# faceting also makes it easy to view individual variables at once--for example, density plots for each survey question

survey_data_melt <- melt(survey_data[,-c(1, 20)])

ggplot(survey_data_melt, aes(value)) + geom_density() + facet_wrap(~variable)

# ggplot also makes it easy to add a trend line to a scatter plot using stat_smooth. 

p + geom_point() + stat_smooth()

# the grey shaded area is the confidence interval of the smoothed trend

# here's an example of boxplots in ggplot2

ggplot(diamonds, aes(y = carat, x = cut)) + geom_boxplot()

# You can "explode" the box plot by adding a layer--geom_jitter--to the boxplot to see where the individual data points fall within the opaque boxplots

ggplot(diamonds, aes(y = carat, x = cut)) + geom_boxplot(outlier.shape = NA) + geom_jitter(position = position_jitter(width = .5, height = 0))

## Fleshing out a ggplot visual

# there are many aspects of the plot that you can maipulate and customize in ggplot

# going back to our saved `p` plot, we can add/edit a title, axis labels
# the \n is a hard return that you can use to create more space between the labels and the plot

pp <- p + geom_point() + ggtitle("Diamonds: Carat versus Price\n") + xlab("\nCarat") + ylab("Price\n")
pp

# formatting of text is accomplished by altering the theme of the plot
# Let's bold the plot and axis titles and resize both, with the plot title being larger than the axis titles

ppp <- pp + theme(axis.title = element_text(face = "bold", size = 14), plot.title = element_text(face = "bold", size = 20))
ppp

# You can also remove elements of the plot via the theme() argument
# Let's remove the shading of the plot usign `element_blank()`

pppp <- ppp + theme(panel.background = element_blank())
pppp

# You can also use custom color palettes via a series of `scale_` arguments
# Here we swap out the standard color palette for a palette of greens

ppppp <- pppp + geom_point(aes(colour = color), size = 3) + scale_color_brewer(palette = "Greens")
ppppp

# themes
# there are some built in variations of the basic theme in ggplot. You can easily swap them just by changing the theme() argument

ppppp + theme_minimal()
ppppp + theme_bw()
ppppp + theme_grey()

# If you want, you can create your own palette of colors and use them in a plot

g_palette <- c("#007934", "#61C250", "#595B5C")

ggplot(group_means, aes(factor(group), mean)) + 
  geom_bar(stat = "identity", aes(fill = factor(group))) +
  geom_text(aes(label = round(mean,2), vjust = -1)) + 
  scale_fill_manual(values = g_palette) + 
  ggtitle("Mean Score by Group\n") + 
  xlab("\nRespondent Group") +
  ylab("Mean\n") +
  theme(axis.title = element_text(face = "bold", size = 14), plot.title = element_text(face = "bold", size = 20), panel.background = element_blank())

## Correlation/R^2 Heatmap

survey_data_correlations_melt <- melt(cor(survey_data_correlations, use = "pairwise.complete.obs"))

survey_data_correlations_melt$value <- round(survey_data_correlations_melt$value, 2)

ggplot(survey_data_correlations_melt, aes(Var1, Var2)) + 
  geom_tile(aes(fill = value)) + 
  geom_text(aes(label=value), size = 5, fontface = "bold") + 
  scale_fill_gradient2(low = "#67a9cf", high = "#ef8a62") + 
  theme_minimal() + 
  theme(panel.grid.major = element_blank(), 
        panel.grid.minor = element_blank(), 
        panel.border = element_blank(), 
        panel.background = element_blank(), 
        axis.title = element_blank(), 
        axis.text = element_text(size = 14, face = "bold"))

# We should remove all values of 1 to make the heatmapping more intuititve and to display better

survey_data_correlations_melt <- survey_data_correlations_melt %>% filter(value < 1) 

ggplot(survey_data_correlations_melt, aes(Var1, Var2)) + 
  geom_tile(aes(fill = value)) + 
  geom_text(aes(label=value), size = 5, fontface = "bold") + 
  scale_fill_gradient2(low = "#67a9cf", high = "#ef8a62") + 
  theme_minimal() + 
  theme(panel.grid.major = element_blank(), 
        panel.grid.minor = element_blank(), 
        panel.border = element_blank(), 
        panel.background = element_blank(), 
        axis.title = element_blank(), 
        axis.text = element_text(size = 14, face = "bold"))

# if the labels are distracting you can remove them

ggplot(survey_data_correlations_melt, aes(Var1, Var2)) + 
  geom_tile(aes(fill = value)) + 
  scale_fill_gradient2(low = "#67a9cf", high = "#ef8a62") + 
  theme_minimal() + 
  theme(panel.grid.major = element_blank(), 
        panel.grid.minor = element_blank(), 
        panel.border = element_blank(), 
        panel.background = element_blank(), 
        axis.title = element_blank(), 
        axis.text = element_text(size = 14, face = "bold"))

# We could also plot the R^2 between questions

survey_data_correlations_melt_r2 <- survey_data_correlations_melt %>% mutate(value = round(value^2, 2))

ggplot(survey_data_correlations_melt_r2, aes(Var1, Var2)) + 
  geom_tile(aes(fill = value)) + 
  scale_fill_gradient2(low = "#67a9cf", high = "#ef8a62") + 
  theme_minimal() + 
  theme(panel.grid.major = element_blank(), 
        panel.grid.minor = element_blank(), 
        panel.border = element_blank(), 
        panel.background = element_blank(), 
        axis.title = element_blank(), 
        axis.text = element_text(size = 14, face = "bold"))

### Additional Resources

## Websites, etc.

# List of the most useful R commands, Personality Project, www.personality-project/r/r.commands.html

# Advanced R, Hadley Wickham, http://adv-r.had.co.nz/

# dplyr vignettes, https://github.com/hadley/dplyr/blob/master/vignettes/introduction.Rmd

# ggplot2 2.1.0 documentation, http://docs.ggplot2.org/current/

# Hadley Wickham on Twitter, https://twitter.com/hadleywickham

# Jenny Bryan's list of resources, http://www.stat.ubc.ca/~jenny/resources.html

# Jenny Bryan on Twitter: https://twitter.com/JennyBryan

# Chris Albon's R tutorials and code snippets, http://chrisalbon.com/#R_Stats

# Interactive walkthrough of R for beginners: http://tryr.codeschool.com/

# DataCamp course for R beginners: https://www.datacamp.com/courses/free-introduction-to-r

# Swirl, an R package that walks you through lessons interactively from within R (may want to wait for the R crash course before wading into this if you have zero R experience): http://swirlstats.com/

# Intro to R video playlist from Google: https://www.youtube.com/playlist?list=PLOU2XLYxmsIK9qQfztXeybpHvru-TrqAP

# There is also a DataCamp course by Bob Muenchen, the author of R for SAS and SPSS Users. You can start it for free, but at some point you need to pay to advance through (not sure of the price): https://www.datacamp.com/courses/r-for-sas-spss-and-stata-users-r-tutorial

# Twitter hashtag #rstats

## Books

# R for Everyone, Jared Lander, http://www.amazon.com/Everyone-Advanced-Analytics-Graphics-Addison-Wesley/dp/0321888030

# R Cookbook, Paul Teetor, http://shop.oreilly.com/product/9780596809164.do

# R in a Nutshell, Joseph Adler, http://shop.oreilly.com/product/0636920022008.do

# An Introduction to Statistical Learning, Gareth James, et al, http://www-bcf.usc.edu/~gareth/ISL/ISLR%20First%20Printing.pdf

### Acknowledgements

# Bob Muenchen for being kind enough to share the code that he uses when teaching a similar course. It was extremely helpful in setting up the content

# Jared Lander's great book, R for Everyone, was helpful to consult and was used for some of the ggplot2 and statistics examples

# Sean Anderson's "An Introduction to reshape2" was used for the introduction to melting and casting data, http://seananderson.ca/2013/10/19/reshape.html
