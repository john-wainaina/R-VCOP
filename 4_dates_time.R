
##############################################################################

## DATE & TIME DATA IN R
## AFROHUN R VCOP COHORT I
## AUTHOR: JOHN WAINAINA </> phomwangi@gmail.com
## DATE: 25TH APRIL 2023

##############################################################################

setwd("C:/Users/jwainaina/Dropbox/R VCOP Training/")

# # Class Outline:

# > Outline packages to use
# > Introduction to functions for date/time
# > examples of various manipulations
# > using combined dataset to exercise date and time manipulation


## loading packages/libraries (if installed previously, go to loading direct (library(package_name)))

install.packages('lubridate')# manipulate date and time data
install.packages('anytime')  # manipulate date and time data
install.packages('chron')    # manipulate date and time data
install.packages('dplyr')    # manipulate data
install.packages('readr')    # load/read data
install.packages('xlsx')     # load/read data


library(lubridate)
library(anytime)
library(chron)
library(dplyr)
library(readr)
library(xlsx)


# Date: a day stored as the number of days since 1970-01-0
# POSIXct: stores date and time in seconds with the number of seconds beginning at 1 January 1970 
# hms: a simple class for storing durations or time-of-day values and displaying them in the hh:mm:ss format
# POSIXlt: stores date and time information as separate components including seconds, minutes, hours, days, et 
# Interval: Intervals represent specific intervals of the timeline, bounded by start and end date-times 
# Period: Record the datetime ranges/time span in “human” times, Like years and month 
# Duration: Record the datetime ranges / time span in second 
# Difftime: The difference between two datetime objects

## A) DATES 

# Dates-represented by the Date class 
# Can be coerced from a character string using the as.Date() or strptime() functions

# Standard: YYYY-MM-DD HH:MM:SS Tz (largest to smallest value)

as.Date("2023-01-01")     # as.Date() handles dates (without times)
as.Date('1990/02/17')     # YYYY-MM-DD
as.POSIXct("2023-01-01")  # POSIXct class + time zones - calendar time - Portable Operating System Interface/standard
as.POSIXlt("2023-01-01")  # POSIXlt class + time zones - local time/when you want to access/extract the different components
as.POSIXlt("2023-04-25 10:30:00")

# create two POSIXct objects representing two different points in time
datetime1 <- as.POSIXct("2023-04-25 10:30:00") #format(datetime1, "%Y-%m-%d")
datetime2 <- as.POSIXct("2023-04-25 11:30:00")

# calculate the time difference between the two points in seconds
difftime(datetime2, datetime1, units = "secs")# "mins")


strptime("2023-01-01", "%Y-%m-%d") # needs format argument

# mathematical operations on dates and times.
# + and -,
# comparisons <, >, ==, <=, >=
# Take care of leap year considerations

as.Date('2023-03-01') - as.Date('2023-02-28')

# Current date/time

Sys.Date()

today()

now()

# Parsing dates/time
# Automatic parsing

anydate(c('2023 Apr 25', '1994 25 03', '1999 01 23'))

# manual parsing

ydm('1994 25 03')

ymd('2023 11 15')

mdy('11 23 2023')

ymd(20230425) # without quotes, without separators

ymd("20230425") # without separators

ymd("2023/04/25")

ymd_hms("2023-01-31 20:11:59") # add hour minutes secs components (_hms)

mdy_hm("01/31/2023 08:01") # (_hm)


parse_date_time(c('Apr 16, 1994', '20 October 1998'), c("%b %d, %Y", "%d %B %Y"))

fast_strptime("April 11 2023", format = "%B %d %Y")

# Making dates and datetimes from components

make_date(2023, 11, 15)


# Extracting components

# You can pull out individual parts of the date with the accessor functions:

# year()
# month() 
# mday()  - (day of the month)
# yday()  - (day of the year)
# wday()  - (day of the week)
# hour() 
# second()


year("2023-11-15")
month("2023-11-15", label = T, abbr = FALSE)
day("2023-11-15")

yday("2023-11-15")

format(as.Date("2023-11-15"), "%Y/%m")

wday("2023-11-15", label = T, abbr = FALSE)

wday(today(), label = T, abbr = F)

Sys.timezone()


# As.Date() and input formats through the 'format = ' argument

# Code	Value
# %d	Day of the month (decimal number)
# %m	Month (decimal number)
# %b	Month (abbreviated)
# %B	Month (full name)
# %y	Year (2 digit)
# %Y	Year (4 digit)

as.Date('1/15/2001', format = '%m/%d/%Y')

as.Date('April 26, 2001', format = '%B %d, %Y')

as.Date('22JUN01', format = '%d%b%y')  


# Date/Time intervals

start_tm <- ymd('1994-01-15')

stop_tm <- ymd('2023-04-25')

interval(stop_tm, start_tm)

as.period(interval(start_tm, stop_tm))

difftime(stop_tm, start_tm)
#(time1, time2, tz, units = c("auto", "secs", "mins", "hours", "days", "weeks"))

difftime(stop_tm, start_tm, units = 'weeks')

10 * (months(6) + days(1))

# Date Arithmetics

stop_tm - start_tm

today() + months(2)

Sys.time() + hours(24)

today() - ymd('1999-04-11')

seq(as.Date('2023-04-19'), as.Date('2023-04-25'))

seq(as.Date('2023-04-19'), as.Date('2023-04-25'), by = 'days')

seq(as.Date('2023-04-19'), as.Date('2023-05-25'), by = 'weeks')



# Round to the nearest week

round_date(ymd("2023-04-28"), 'week')

round_date(ymd("2023-04-28"), 'month')

# Round to the previous time unit

floor_date(ymd("2023-04-25"), 'week')

# Round to the next time unit

floor_date(ymd("2023-04-25"), 'week')

floor_date(ymd("2023-04-25"), 'month')


# Round to the next time unit - top

ceiling_date(ymd("2023-04-25"), 'week')

ceiling_date(ymd("2023-04-25"), 'month')


# >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

# Practicals in breakout rooms

combined <- read.csv(file = here(getwd(), 'Datasets', 'combined.csv'), header = T)

copy <- combined

names(copy)

copy %>% select(contains('date')) %>% names()

class(copy$cpap_start_date)

x <- 
  copy %>% 
  mutate(start_time = as.Date(cpap_start_date),
         stop_time = as.Date(cpap_stop_date)) %>% 
  select(cpap_start_date, start_time, cpap_stop_date, stop_time) %>% 
  head(10)

y <- 
  copy %>% 
  mutate(start_time = strptime(cpap_start_date, "%Y-%m-%d"),
         stop_time = strptime(cpap_stop_date, "%Y-%m-%d")) %>% 
  select(cpap_start_date, start_time, cpap_stop_date, stop_time) %>% 
  head(10)


lapply(x, class)
lapply(y, class)

# Arithmetics

# Difference between start and stop dates


x %>% 
  mutate(difference_days = as.numeric(difftime(stop_time, start_time, units = 'days')),
         difference_hours = as.numeric(difftime(stop_time, start_time, units = 'hours')),
         difference_weeks = as.numeric(difftime(stop_time, start_time, units = 'weeks'))) %>% 
  select(stop_time, start_time, difference_days, difference_hours, difference_weeks) %>% 
  #forestmangr::round_df(., 1) %>% 
  head(10)

x %>% mutate(difference = as.numeric(stop_time - start_time)) # direct minus does it too, simply, later make numeric


# Time
a <- copy %>% select(ends_with('time')) %>% names()

copy$cpap_start_time

copy$cpap_stop_time

## Format data's cpap_start_time to 24 hour system

# convert to factor
copy$cpap_start_time <- as.factor(copy$cpap_start_time)

# clean up levels which don't make sense to missing

levels(copy$cpap_start_time)[levels(copy$cpap_start_time) == "N.D"] <- NA_character_
levels(copy$cpap_start_time)[levels(copy$cpap_start_time) == "AM"] <- NA_character_

copy$cpap_start_time <- tolower(copy$cpap_start_time) # make the values/characters to lower case - uniformity

# create column for time units as found in the data
copy$start.time.ampm = ifelse(grepl('am', copy$cpap_start_time),  'am', 
                              ifelse(grepl('pm', copy$cpap_start_time),  'pm', NA)) 

copy$start.time <- gsub("[ap]m\\s*", "", copy$cpap_start_time) # remove am/pm and white spaces from the values

copy$start.time <- gsub('\\.', ":", copy$start.time) # replace "." with ':' where applicable

copy$start.time <- trimws(copy$start.time) #Remove leading and/or trailing whitespace from character strings.

# introduce ':' and '00' in values that look like: '8' to be '8:00' or '12' to '12:00'

copy$start.time <- ifelse(grepl(':', copy$start.time), copy$start.time, paste0(copy$start.time, ':00')) 

# to times that now look like 'NA:00', remove them entirely to be missing (NA)
copy$start.time <- ifelse(grepl('NA', copy$start.time, ignore.case = T), NA, copy$start.time)

# now the time column (start.time) looks like time
# next steps: make it uniform: 24 hour system by using 
# # its values together with am/pm column we made earlier
# after that, do the same for cpap_stop_time
# after standardizing both, find the difference in hours



