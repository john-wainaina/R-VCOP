

###################################################

## SUMMARY STATISTICS IN R

##################################################

rm(list = ls(all.names = T)); cat('\14')


pkgs <- c('tidyverse', 'lubridate', 'ggpubr', 'dplyr', 'extrafont', 'gtsummary')
lapply(pkgs, require, character.only = T)
loadfonts(device = "win")


# create working directory

setwd("C:/Users/jwainaina/Dropbox/R VCOP Training")

city_temp <- read_csv(file = here::here(getwd(), "Datasets", "city_temperature.csv"))
city_temp <- city_temp %>% 
  group_by(Country) %>%
  sample_n(size = 500, replace = FALSE) %>%
  ungroup()

data <- city_temp

# ----------------------------------------------------------------

lapply(data, class)

install.packages('weathermetrics')
library(weathermetrics)
data <- data %>% 
  mutate(Temperature = fahrenheit.to.celsius(AvgTemperature, round = 1))

# Minimum and maximum

min(data$Temperature, na.rm = T)
max(data$Temperature, na.rm = T)


# Range

max(data$Temperature, na.rm = T) - min(data$Temperature, na.rm = T) 

range(data$Temperature, na.rm = T)

# Mean

mean(data$Temperature)


# Median

median(data$Temperature)


# First and third quartile

quantile(data$Temperature)

quantile(data$Temperature, .25)

quantile(data$Temperature, .75)

# Other quantiles

quantile(data$Temperature, .95)

# Interquartile range

quantile(data$Temperature, .75) - quantile(data$Temperature, .25)
IQR(data$Temperature)

# Standard deviation and variance

sd(data$Temperature)

var(data$Temperature)


# Summary

summary(data$Temperature)


# Correlation

cor(data$Temperature, data$Month)


# Contingency table

table(data$Region)

table(data$Region, data$Temp_group)

xtabs(~ data$Region + data$Temp_group)

round(prop.table(table(data$Region + data$Temp_group), 1), 2)

# Barplot
ggplot(data = data, aes(x = Temp_group)) +
geom_bar()

# Histogram

hist(data$Temperature)


# Boxplot

boxplot(data$Temperature)
boxplot(data$Temp_group  ~ data$Region)


# Scatterplot

plot(data$Temperature, data$AvgTemperature)

plot(data$Temperature, data$AvgTemperature)

ggplot(data,  aes(x = Temperature, y = AvgTemperature)) +
  geom_point()

# Line plot

ggplot(data,  aes(x = Month, y = Temperature)) +
  geom_line()+
  geom_point()

# QQ-plot

qqnorm(data$Temperature)

qqline(data$Temperature)

library(ggpubr)
  
ggqqplot(data$Temperature)

# Density plot

plot(density(data$Temperature))

ggplot(data) +
  aes(x = Temperature) +
  geom_density()



