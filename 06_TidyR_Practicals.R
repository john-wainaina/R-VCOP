

###################################################################

## TOPIC: TidyR Participant-led Practicals
## AFROHUN R VOP - SESSION 5
## Saturday, 06/05/2023
## JOHN WAINAINA
## Email: </> phomwangi@gmail.com

##################################################################

#library(summarytools)
# Set working directory

setwd("C:/Users/jwainaina/Dropbox/R VCOP Training")

# load requisite packages

library(here)
library(tidyverse)
library(lubridate)
library(data.table)

# read in data, subset
covid <- read_csv(file = here::here(getwd(), "Datasets", "COVID-19", "covid_19_clean_complete.csv"))

covid <- covid[, -c(3:4)]

# rename columns
names(covid)[names(covid) == "Country/Region"] <- "Country"

# create/extract month column from Date and make it a column - format m/Y

country_data <- covid %>% mutate(Month = format(floor_date(Date, "month"), "%m-%Y"))

# Summarise sum of cases/deaths per month and country
country_data <- country_data %>% 
  group_by(Country, Month) %>% 
  dplyr::summarise(Confirmed = sum(Confirmed, na.rm = T),
                   Deaths = sum(Deaths, na.rm = T),       
                   Recovered = sum(Recovered, na.rm = T),
                   Active = sum(Active, na.rm = T),
                   Region = unique(`WHO Region`))

# Find number of countries in the data, sum of each of cases per country

length(unique(country_data$Country))

# sum of each of cases per country

nation_level <- 
country_data %>% 
  group_by(Country) %>% 
  dplyr::summarise(Confirmed = sum(Confirmed, na.rm = T),
                   Deaths = sum(Deaths, na.rm = T),       
                   Recovered = sum(Recovered, na.rm = T),
                   Active = sum(Active, na.rm = T),
                   Region = unique(Region))

# sum of each of cases per region

region_level <- 
  country_data %>% 
  group_by(Region) %>% 
  dplyr::summarise(Confirmed = sum(Confirmed, na.rm = T),
                   Deaths = sum(Deaths, na.rm = T),       
                   Recovered = sum(Recovered, na.rm = T),
                   Active = sum(Active, na.rm = T),
                   Region = unique(Region))


# >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

# Tidying through pivoting

# country_data

# gather cases only, don't gather country name, date and region

setDT(country_data)

#gather(dataset, key = "key", value = "value", na.rm = T)

long_data_1 <- gather(country_dataata, key = "Variables", value = "Value")

long_data_1 <- gather(country_data, key = "Variables", value = "Value", -c('Country', 'Month', 'Region'))


# do the same with pivot_longer for cases only, don't pivot country name, date and region

pivot_longer(data, c(x, y, z), names_to = "key", values_to = "value")

pivot_longer(country_data, c("Confirmed", "Deaths", "Recovered", "Active"), names_to = "Variables", values_to = "Value")


# Using melt()
melt(country_data,
     id.vars = c("Country", "Month", "Region"),
     measure.vars = c("Confirmed", "Deaths",    "Recovered", "Active"),
     variable.name = "Variable",
     value.name = "Value")


# >>>>>>>>>>>>>>>>>> Making data wide from long <<<<<<<<<<<<<<<<<<<<<<<<<<<<<
# spread()

wide_data_1 <- spread(long_data_1, key = "Variables", value = "Value")

# pivot_wider()

wide_data_1 <- pivot_wider(long_data_1, names_from = 'Variables', values_from = "Value")

# >>>>>>>>>>>>>>>> >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

# Separate

separate(data = wide_data_1, col = Region, into = c("Name 1", "Name 2"), sep = " ")

separate(data = wide_data_1, col = Month, into = c("Month_Num", "Year"), sep = "-")


# Unite

unite(covid, col = c("Country", 'Province/State'), sep = " - ")

covid


