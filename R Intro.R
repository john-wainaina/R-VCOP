
##################################################################

## AFROHUN: R for HEALTH SURVEYS DATA ANALYSIS
## R VIRTUAL COMMUNITY OF PRACTICE 

## START DATE: 19TH APRIL 2023
## Author: John Wainaina <\> Email: phomwangi@gmail.com

##################################################################

# Clear things in this order: working environment ; clear plots ; clear console 

rm(list = ls(all.names = T)); if(!is.null(dev.list())) dev.off(); cat("\014")


date() 
Sys.Date()

# 1: Setting up working directory


setwd("C:\\Users\\jwainaina\\Dropbox\\R VCOP Training\\")

setwd()# Set the working directory.
getwd() #: Returns the current working directory.
dir() # Return the list of the directory.

# 2: Packages/functions
## a) Base R

mean(cars$speed)
median(cars$dist)

max(cars$speed)
quantile(cars$speed)

# b) From CRAN - online
## Installing packages

install.packages('package_name')

install.packages("dplyr") #data wrangling/munging/manipulation
install.packages("lubridate") # working with dates
install.packages("ggplot2") # plotting visualizations
install.packages("survival") # survival analysis

## c) from github

install.packages("devtools")
library(devtools)
install_github("hadley/dplyr")


# 2-i: Loading packages/libraries

library(dplyr)
library(lubridate)
library(ggplot2)
library(survival)

# 3: R Environment & Operators

## objects in the workspace 
## Use of '<-' or '='

session_start <- "Hello, R Virtual Community of Practice."

today <- date()

paste0(session_start, ' Today is ', today)

my_vector <- c(1, 2, 3, 4, 5, 6, 7, 8, 9, 10)

my_vector <- c(1:10)

6 %in% my_vector


# R Operators 
#Arithmetic 

20+3 # +	addition
10-7 # -	subtraction
3*3 # *	multiplication
16/4 # /	division
2^2 # ^ or **	exponentiation
5%%2 # x %% y	modulus (x mod y) 5%%2 is 1 - Modulus (Remainder from division)
5%/%2 # x %/% y	integer division 5%/%2 is 2

#Logical
<	less than
<=	less than or equal to
>	greater than
>=	greater than or equal to
==	exactly equal to
!=	not equal to
!x	Not x
x | y	x OR y
x & y	x AND y
isTRUE(x)	test if X is TRUE

a <- seq(1, 5)
b <- seq(3, 12)

a %in% b #%in% # matching values

&	#Element-wise Logical AND operator. It returns TRUE if both elements are TRUE
  &&	#Logical AND operator - Returns TRUE if both statements are TRUE
  |	#Elementwise- Logical OR operator. It returns TRUE if one of the statement is TRUE
  ||	#Logical OR operator. It returns TRUE if one of the statement is TRUE.
  !	#Logical NOT - returns FALSE if statement is TRUE
  
  # 4: R Inbuilt data
  ## function 'data()'
  
  Titanic

titan <- data.frame(Titanic)

help("Titanic")
help("dplyr")

head(titan) # first 6 rows
tail(titan) # last 6 rows
colnames(titan) # column names/variable names
dim(titan) # dimensions rows/ observations/records X columns/variables
str(titan) # structure: class of the dataset and dimension, features of each column
summary(titan) # summary data for each column
summary(titan$Freq) # summary of a column; note use of `$`


# 5: Create simple data in session

example_data <- data.frame(name = c('Mary', 'Abby', 'James', 'John', 'Robert', 'Bruno'),
                           sex = c('female', 'female', 'male', 'male', 'male', 'male'),
                           age = c(23, 24, 35, 17, 33, 29),
                           grade = c(1:6),
                           exam_attempt = c(rep(1, 3), rep(2, 3))
)


# 6: Loading external data 
## load your data from a folder of your choice, specify the path accordingly

sample_data <- read.csv(file = 'sample_data.csv')

sample_data <- read.csv(file = "C:\\Users\\jwainaina\\Dropbox\\R VCOP Training\\sample_data.csv")


# 7: Plotting Data
# These data are inbuilt so no need to load them from elsewhere
## a) Creating a histogram:

hist(CO2$uptake)

## b) Creating a scatter plot:

plot(Orange$age, Orange$circumference)

# Customize labels/title
plot(Orange$age, Orange$circumference, 
     
     xlab="Age", ylab="Circumference", 
     
     main="Circumference vs. Age", 
     
     col="blue", pch=16)


# 8: Perform tests e.g., normality tests

normal_data <- rnorm(30, mean = 2, sd = 0.5)

# Shapiro test

shapiro.test(normal_data)

non_normal_data <- rexp(30, rate=0.5)

shapiro.test(non_normal_data)


#create data that follows an exponential distribution
non_normal_data <- rexp(200, rate = 3)

#perform kolmogorov-smirnov test

ks.test(normal_data, 'pnorm')

ks.test(non_normal_data, 'pnorm')


# Getting Help on an R Package or any Built-in R Object or function

help(package_or_function_name)
help("package_or_function_name")
?package_or_function_name

# - Google the problem
# - Ask colleagues

# The End!
cat("First session ended at ", format(Sys.time(), "%I:%M %p"), "\n", sep = "", "Thank you!")

