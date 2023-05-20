

####################################################

## TOPIC: Data Manipulation
## AFROHUN R VOP - SESSION
## Wednesday, 10/05/2023
## JOHN WAINAINA
## Email: </> phomwangi@gmail.com

##################################################################

rm(list = ls(all.names = T)); cat('\14')

# create working directory

setwd("C:/Users/jwainaina/Dropbox/R VCOP Training")

# load packages

library(dplyr)
library(data.table)
library(tidyverse)
library(extrafont)
loadfonts(device = "win")

# Data manipulation will start around below functions

# filter()
# select() - where(), starts_with(), contains(), ends_with() etc.
# subset()
# group_by()

# summarise() - n(), central tendency, spread, range, position, count, logical
# mutate()
# ifelse()
# rowwise()
# rowMeans()
# colMeans()
# arrange()
# relocate()
# aggregate()

# load the dataset
covid <- read_csv(file = here::here(getwd(), "Datasets", "COVID-19", "covid_19_clean_complete.csv"))


#> Rename cols - multiple ways of doing it

names(covid)[names(covid) == c("Province/State", "Country/Region", "WHO Region")] <- c("Province",'Country', 'Region')

names(covid)[c(1,2,10)] <- c('Province','Country', 'Region')

covid <- covid %>% rename('Province' = 'Province/State',
                          'Country' = "Country/Region",
                          'Region' = 'WHO Region')
setnames(covid, 
         c('Province/State', "Country/Region", 'WHO Region'),
         c('Province','Country', 'Region'))


copy <- copy(covid) # create a copy of the dataset

copy <- covid

copy <- as.data.table(copy) # create a data.table class of the data as well

setDT(copy) # using setDT() function // copy <- as.data.table(copy)

# Select() - works on columns

copy <- copy %>% dplyr::select(-c(Lat, Long))  # select by deselecting using '-'

copy <- copy %>% select(-c(3:4))  # deselect

select(copy, -c(Lat, Long)) 

# using indexing braces []

dataset[rows, cols, ...] # structure it takes

DT[i, j, ....] # structure it takes; DT-data, i - rows, j - columns, ... others

copy[, c("Country", "Confirmed")]
copy[, c(2, 4)]

list_names <- c("Country", "Confirmed")

data_copy <- as.data.table(copy)

data_copy[, c("Country", "Confirmed") := NULL]


copy[, -c("Country", "Confirmed")]


copy[, c('Lat', 'Long') := NULL] # by name, data.table

copy <- copy %>% dplyr::select(-c(3,4)) # by index/position

copy <- copy[, -c(3,4)]

names(copy)[6:9] <- paste0('cases_', names(copy)[6:9] ) # add preceeding string before select names

copy %>% dplyr::select(contains('cases_')) #use contains with select()

copy %>% dplyr::select(Country, contains('cases_'), Region) 

copy %>% dplyr::select(starts_with('c')) # use starts_with with select()

copy %>% dplyr::select(ends_with('ed') | ends_with('e')) # use ends_with with select()

location_names <- c('Province','Country', 'Region') # create a vector of names to select
  
copy %>% dplyr::select(all_of(location_names)) #use all_of with a vector of names above

location_names <- c('Province','Country', 'Region', 'Place') # create a vector with names to select

copy %>% dplyr::select(any_of(location_names)) # use any_of with select


# check class of columns at once
lapply(copy, class)

copy %>% dplyr::select(where(is.numeric)) # use where() with select()

copy %>% dplyr::select_if(is.numeric) # select_if -- followed by condition

copy %>% dplyr::select(last_col()) # select last column

copy %>% dplyr::select(last_col(1)) #select second last, in that order


# >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> filter() - works on rows <<<<<<<<<<<<<<<<<<

dataset[i, j, ...] # structure of dataframe/data tables

# FILTERING by position of the rows
copy[1, ] # filter first row

copy[1:10, ] # filter row 1 to 10

copy[1000:nrow(copy), ] # filter row 1000 to last in the dataset

copy[Region == 'Africa', ] # filter using column values, where Region is Africa

copy %>% filter(Region == "Africa")



a <- copy %>% filter(Region == "Africa" | Region == "Europe") # OR

b <- copy %>% filter(Region == "Africa" & Region == "Europe") # AND , &

c <- copy %>% filter(Region %in% c('Africa', 'Europe')) # using in as %in% function

# include arithmetic operators in filter (=, <, <=, >, >=) and BOOLEAN Operators (&, |)
d <- copy %>% filter(Region %in% c('Africa', 'Europe') & as.Date(Date) <= '2020-05-01')

e <- copy %>% filter(!Region %in% c('Africa', 'Europe')) # - ! - NOT

f <- copy %>% filter(cases_Deaths >= 1000 & cases_Deaths <= 2000)

g <- copy %>% filter(between(cases_Deaths , 1000, 2000))

copy %>% filter(cases_Deaths >= 1000 & cases_Deaths <= 2000 & Region == "Africa")

copy[cases_Deaths >= 1000 & cases_Recovered > 1000000, ]#[order(Region)]

k <- copy[Region == "Africa" & Country == 'Kenya' & cases_Deaths <1000, ]

# Subset() - on rows

copy %>% subset(cases_Confirmed > 10000 & cases_Deaths <1000) # use subset to filter

# use grepl for string pattern with subset
copy %>% subset(grepl('med', Region, ignore.case = T)) 

# >>>>>>>>>>>>>>>>> group_by() <<<<<<<<<<<<<<<<<<<<<<<<<<<<

copy %>% 
  group_by(Region) %>% # group by a column so results are grouped
  summarise(n= n()) %>% # get summary by group
  arrange(desc(n)) # arrange output by descending/decreasing order

copy[, .N, by = Region] # data.table syntax - get counts grouped by Region column

copy[, .N, by = Region][order(-N)] #do above with arranged output by descending/descreasing

# >>>>>>>>>>> mutate() - create, modify, delect columns

# - with ifelse()
# - with case_when()
# - with across()


# create new column 'Africa using contents of Region column - using ifelse()

ifelse(test = 'test', 'action/result if yes', 'action/result if test is no')

copy <- copy %>% mutate(Africa = ifelse(Region == 'Africa', 'Africa Region', 'Non-Africa Region'))

copy$Africa <- ifelse(copy$Region == 'Africa', 'Africa Region', 'Non-Africa Region')

copy %>% mutate(
  Region2 = ifelse(Region == 'Eastern Mediterranean', 'Mediterranean',
                   ifelse(Region == 'Europe', 'Europe',
                          ifelse(Region == 'Africa', 'Afrika',
                                 ifelse(Region == 'Americas', 'America',
                                        ifelse(Region == 'Western Pacific', 'Pacific', 'Asia'))))))

copy$Region2 <- ifelse(Region == 'Eastern Mediterranean', 'Mediterranean',
                       ifelse(Region == 'Europe', 'Europe',
                              ifelse(Region == 'Africa', 'Afrika',
                                     ifelse(Region == 'Americas', 'America',
                                            ifelse(Region == 'Western Pacific', 'Pacific', 'Asia')))))

# using case_when() with mutate

case_when('test' ~ 'action/result if true', TRUE ~ 'action/result if not any of above')

copy %>% mutate(Africa = case_when(Region == 'Africa' ~ 'Africa Region',
                                  TRUE ~ 'Non-Africa Region'))

# perform operation using mutate on selected columns
copy %>% 
  mutate(across(contains('cases_'), ~ . + 0))

############################################################################

# Create summaries using above dplyr verbs

# A) - create a summary of COVID related cases per Continent

region_summ <-
copy %>% 
  filter(!is.na(Region)) %>% 
  group_by(Region) %>% 
  dplyr::summarise(
            Confirmed = sum(Confirmed, na.rm = T),
            Deaths = sum(Deaths, na.rm = T),
            Recovered = sum(Recovered, na.rm = T),
            Active = sum(Active, na.rm = T)) %>% 
  dplyr::mutate(`% Deaths` = Deaths/Confirmed*100,
                `% Recovered` = Recovered/Confirmed*100,
                `% Active` = Active/Confirmed*100)  %>% 
  select(Region, starts_with('%')) %>%
  mutate(across(contains('%'), round, digits = 0))  %>%
 # mutate_if(is.numeric, round, digits = 0) %>% 
  pivot_longer(., cols = c(2:4), names_to = 'Indicator', values_to = '%') 

  # # Previously
  # across(a:b, mean, na.rm = TRUE)
  # # Now
  # across(a:b, \(x) mean(x, na.rm = TRUE))

apply(region_summ[, 6:8], 2, round, digits = 0)


region_summ %>% 
  mutate(Total = rowSums(select(., 2:4)))

region_summ %>% 
  rowwise() %>% 
  mutate(Total = sum(`% Deaths`, `% Recovered`, `% Active`))

