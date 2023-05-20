
###################################################################

## TOPIC: DATA CLEANING
## AFROHUN R VOP - SESSION 2 - 22/04/2023
## SATURDAY, 21/04/2023
## JOHN WAINAINA
## Email: </> phomwangi@gmail.com

##################################################################

# ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

## > SESSION OUTLINE
# > Read in datasets
# > Column names and renaming
# > Combine datasets into 1
# > Various cleaning (including strings/numerics and dates)
# > Missing data
# > outliers
# > Duplicates

# ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

rm(list = ls(all.names = T)); if(!is.null(dev.list())) dev.off(); cat("\014")

#pacman::p_load(dplyr, data.table, lubridate, stringr, readr, xlsx, gdata)

# install.packages('dplyr')
# install.packages('data.table')
# install.packages('lubridate')
# install.packages('stringr')
# install.packages('readr')
# install.packages('xlsx')

library(dplyr)        #data manipulation/wrangling/cleaning etc.
library(data.table) #data manipulation, just like dplyr on dataframes
library(lubridate) #manipulate/manage date data
library(stringr) #manage string data
library(readr) #read .csv data 
library(xlsx) #read xlsx data format

# Read 4 Datasets to environment

HospA <- read.xlsx('HospA.xlsx', sheetName = 'Sheet1', colIndex = 1:37, header = T)
HospB <- read.xlsx('HospB.xlsx', sheetName = 'Sheet1', colIndex = 1:37, header = T)
HospC <- read.xlsx('HospC.xlsx', sheetName = 'Sheet1', colIndex = 1:37, header = T)
HospD <- read.xlsx('HospD.xlsx', sheetName = 'Sheet1', colIndex = 1:37, header = T)

#HospA <- read.csv('HospA', header = T)

# Data types

names(HospA)

class(HospA$outcome) # check data class/type

sapply(HospA, class) # applying class function on every column


# Combine the datasets into one - master
# - If datasets have same no. of columns and the columns are the same (characteristics), 
## - combining them together will be simply be adding rows on the first one (binding rows together)
### - If column names are not labelled the same, 
#### - even when the characteristics are the same, you make the names similar first
##### - Use function rbind

combined<-rbind(HospA,HospB,HospC,HospD) #Error in match.names(clabs, names(xi)) : 
                                          #names do not match previous names

# Make names (column names/colnames, variable names) similar/identical
# Steps? Use names of one or write out names and make them names for each dataset
# names(HospA) / colnames(HospA)

variables <- c("ipno",                  "gest",                      "age_adm",                  
           "gender",                    "birth_wt",                  "adm_wt",                   
           "delivery",                  "apgar5min",                 "multiple_delivery",        
           "maternal_diabetes",         "adm_dx",                    "sepsis_dx",                
           "severe_cong_malformations", "hypothermia",               "sas_recorded",             
           "cpap_start_date",           "cpap_start_time",           "cpap_fio2_start",          
           "cpap_h2o_level_start",      "spo2_obs_24hrs",            "heart_rate_obs_24hrs",     
           "resp_rate_obs_24hrs",       "no_cpap_fio2_24hrs",        "no_cpap_pressure_cm",      
           "time_resp_rate_less_60bpm", "time_spo2_increase_90",     "cpap_fio2_weaning_doc",    
           "cpap_pressure_weaning_doc", "cpap_stop_date",            "cpap_stop_time",           
           "fio2_at_stop_time",         "cpap_pressure_stop_time",   "spo2_stop_time",           
           "nasal_position_doc",        "nasal_skin_cond_doc",       "los",                      
           "outcome") # A list of col names

# Use names of HospA to rename all other datasets

names(HospA)

names(HospB)

names(HospC)

names(HospD)

names(HospB) <- names(HospA) # names(HospB) <-  variables
names(HospC) <- names(HospA) # names(HospC) <-  variables
names(HospD) <- names(HospA) # names(HospD) <-  variables

# What if you wanted to just rename a few names/variables/column names? Several ways/functions

# colnames() # base R
# names()    # base R
# setnames() # data.table package
# rename()   # dplyr package
# dimnames() # base R

# Create a sample data frame
df <- data.frame(a = 1:5, b = letters[1:5])
df
print(df)
colnames(df) <- c('colA', 'colB')
names(df) <- c('colA', 'colB')
setDT(df) # convert data.frame to data.table format
setnames(df, c('colA', 'colB'))

rename(df, c(colA = a,
             colB = b)) # new_name = old_name

rename(dataset, c(new_name1 = old_name1,
                  new_name2 = old_name2))


# -----------------------------------------------------------------------------
# Before binding the rows together, 
## how to identify the individual datasets within the master to be formed?

# Add column of hospital name for each record/observation/row
# Various ways

## using $ operator
## using mutate()
## using cbind() - 'column' bind/append column to others

HospA$hospital <- 'HospA' # HospA <- HospA %>% mutate(hospital = 'HospA')
HospB$hospital <- 'HospB' # HospB <- HospB %>% mutate(hospital = 'HospB')
HospC$hospital <- 'HospC' # HospA <- HospA %>% mutate(hospital = 'HospC')
HospD$hospital <- 'HospD' # HospA <- HospA %>% mutate(hospital = 'HospA')

# The new column created and place at the end, want it to be the first column

HospA <- HospA %>% select(hospital, everything())# ordered hosp and everything else after it
HospB <- HospB %>% select(hospital, everything())
HospC <- HospC %>% select(hospital, everything())
HospD <- HospD %>% select(hospital, everything())

# Now combine the datasets into one - combined
# First confirm if all have identical names

all.equal(names(HospA), names(HospB), names(HospC), names(HospD))

# combine; several ways >> rbind // as a list
combined <- rbind(HospA, HospB, HospC, HospD)

combined <- do.call('rbind', list(HospA, HospB, HospC, HospD)) # being verbose

# -----------------------------------------------------------------------------

## DATA CLEANING
# >>>>> Use combined dataset

# -----------------------------------------------------------------------------

summary(combined)

# 1) Missing data > is.na() // na.omit() // complete.cases()

table(is.na(combined$ipno))

combined %>% filter(is.na(gest)) %>% select(ipno, birth_wt)

clean_ipno_dataset <- combined %>% filter(!is.na(ipno))


# exclude rows with any missing data 
df_clean <- combined %>% na.omit()
df_clean <- na.omit(combined)
df_clean <- combined[complete.cases(combined), ]

# remove rows that contains all NA's (atleast after the hospital name col - added previously)
combined <- combined[rowSums(is.na(combined)) != ncol(combined[-1]), ]

# Exclude records with missing IP number - we cannot identify/trace them back 
combined <- combined %>% filter(!is.na(ipno))


# Column by column
# - gest - gestation

class(combined$gest)

unique(combined$gest)

# replace "???" with NA values in the character column
combined$gest[combined$gest == "???"] <- NA_character_

combined$gest <- as.numeric(combined$gest) # would also coerce any non-numeric to NA

table(is.na(combined$gest))

unique(combined$apgar5min)


# combined %>% 
#   filter(
#     if_any(
#     .cols = everything(),
#     .fns = \(col) is.na(col)
#   )
# )


# - gender
unique(combined$gender)

combined$gender <- as.factor(combined$gender)

levels(combined$gender)[levels(combined$gender) == 'F'] <- 'Female'
levels(combined$gender)[levels(combined$gender) == 'M'] <- 'Male'
levels(combined$gender)[levels(combined$gender) == 'Y'] <- 'Female'


# - mode of delivery
unique(combined$delivery)
combined$delivery <- as.factor(combined$delivery)

levels(combined$delivery)[levels(combined$delivery) == 'ECS'] <- 'Emergency C/S'
levels(combined$delivery)[levels(combined$delivery) == 'EMCS'] <- 'Emergency C/S'
levels(combined$delivery)[levels(combined$delivery) == 'ELCS'] <- 'Elective C/S'

# - clean up:

# > apgar5min (should be a number 1:10, if not, make them NA), 
# > cpap_start_time and cpap_stop_time (anything not time, make NA)

# - Cleaning where strings appear with digits together

# gsub()
# str_remove_all()

# Takes format: gsub('pattern, replacement, data)

string_nums <- c('123age', '45', 'aes2', 'grad45', 3)
string_nums_clean <- gsub('[^0-9]', "", string_nums) # `^` negates/except/not numeric digits

# when string is specific?
gsub('days', "", c('13 days', '25days', '17months')) # works for what you have specified
gsub('days|months', "", c('13 days', '25days', '17months')) # days / months
gsub('[^0-9]', "", c('13 days', '25days', '17months')) # when not specific

library(stringr) #str_remove_all()
string_nums_clean <- str_remove_all(string = string_nums, "[^0-9]")

# Remove digits instead of characters
gsub("[^a-z]", "", "abc123def456")

gsub("[^a-z]", "", string_nums)

# introduce ifelse(), grepl() to use with mutate alongside gsub()

ifelse(test, yes, no)
grepl(pattern = '', x, ignore.case = T|F)
gsub(pattern = 'xxx', replacement = 'xx', data|column)


combined <-
  combined %>% 
  mutate(los_days = 
           ifelse(grepl('day', tolower(los)), as.numeric(gsub('\\D', "", los)), NA)) # \\D - match non-digits

combined <-
  combined %>% 
  mutate(los_hours = 
           ifelse(grepl('hour|hr|h', los, ignore.case = T), as.numeric(gsub('\\D', "", los)), NA))


# Cleanup for:
# >> months
# >> no time units to 'days

# make all these (hours, days, months) to a new column called 'Length_of_stay' in days

# Clean up date data

# make any date string to standard '%Y %m %d' // YMD
dates_data <- c('2023 Dec 5') # change to different orders and try
lubridate::parse_date_time(dates_data, orders = c("dmy", "dby", "my", "by", "ydm", "ymd"))


date_str <- "2023-04-22"
date_str <- as.Date(date_str) # as.Date() - convert string to date

text <- c("John's birthday is on 10/31/2022.", "date of 10:01:2019 ")

gsub("[^0-9]", "", text)  # removes all non-digits 
gsub("[^0-9/]+", "", text)  # removes all other than (0-9 digits and /)
gsub("[^0-9/:]+", "", text)  # removes all other than (0-9 digits, /, :)

date_str <- gsub("[^0-9/:]+", "", text)  # removes all other than (0-9 digits, /, :)

date_str <- gsub(":", "/", date_str)  # replace : with /
date_str <- as.Date(date_str, format = "%m/%d/%Y") # returns standard YMD


text <- "John's birthday is on 10-31-2022."

date_str <- gsub("[^0-9-]", "", text)  # removes all other than (0-9 digits and -)
date_str <- as.Date(date_str, format = "%m/%d/%Y") # returns standard YMD

# Clean up date & time to return dates only

date_time <- c("3/12/2018 10:30 am", "15/01/2010 2:15 PM", "8/06/1994 4:00 am", "1/1/2023 8:00pm")

# remove time units and extract dates only

gsub("[ap]m\\s*", "", date_time) # \\s represents any whitespace/space
                                 # [ap]m\\s* matches any string that contains either "am" or "pm", 
                                 # followed by zero or more whitespace characters
#date_time <-  gsub("[ap]m", "", tolower(date_time))
dates_only <- gsub(" .*", "", date_time) # " .*" matches any character after first space

dates_only <- as.Date(dates_only, format = "%d/%m/%Y") # returns standard YMD


# Outliers

summary(combined$los_days)

# Create a boxplot to identify outliers

boxplot(combined$los_days)

# Tukey's method: identifying outliers 
# based on the IQR. 
# data points that fall more than 1.5 times the IQR above 
# the upper quartile or below the lower quartile are 
# identified as outliers.

boxplot.stats(combined$los_days)$out

# Use Grubbs' test to identify outliers
library(outliers)

grubbs.test(combined$los_days)

# Replace outliers? 
# >> with NA?
# >> with a specific value?

# Replace the outlier values with NA

setDT(combined)
combined[los_days < 1 | los_days > 30, los_days := NA] # data.table method

combined$los_days <- ifelse(combined$los_days <1 | combined$los_days > 30, NA, combined$los_days) # use ifelse()
                            
                            
# Missing values - explore replacements

table(is.na(combined$gest))

copy <- combined

copy$gest[is.na(copy$gest)] <- 34 # replace with 34

table(is.na(copy$gest)) # confirm if worked

copy$gest <- ifelse(is.na(copy$gest), round(mean(copy$gest, na.rm = T), 0), copy$gest) # replace by mean of non-missing

copy$gest[is.na(copy$gest)] <- round(mean(copy$gest, na.rm = T), 0) # replace by mean of non-missing

# Duplicates
# identify
# Keep only the non-duplicated rows

table(duplicated(combined$ipno))

combined <- combined %>% filter(!duplicated(ipno)) # ! negating/not operator

combined <- combined[!duplicated(combined), ]

# ---------------------------------------------------------------------------

cat('Huuuh..., enough of dealing with messes today!', "\n", 'Find some more messes and deal with them, cheers!')

cat("The next class will be on ", format(Sys.Date() + 4, "%b %d %Y"))



