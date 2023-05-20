


###################################################################

## TOPIC: TidyR
## AFROHUN R VOP - SESSION 5
## Wednesday, 03/05/2023
## JOHN WAINAINA
## Email: </> phomwangi@gmail.com

##################################################################

# ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++


rm(list = ls(all.names = T)); if(!is.null(dev.list())) dev.off(); cat("\014")

setwd("C:/Users/jwainaina/Dropbox/R VCOP Training/R Codes")

library(tidyverse)

install.packages('pacman'); library(pacman)
pacman::p_load(tidyverse)


combined <- read.csv('C:/Users/jwainaina/Dropbox/R VCOP Training/Datasets/combined.csv')

#write.csv(combined, file = "combined.csv")


# “Pivoting” which converts between long and wide forms: pivot_longer() and pivot_wider(), 
# Splitting and combining character columns. 
# Use separate() and extract() to pull a single character column into multiple columns; 
# use unite() to combine multiple columns into a single character column.
# Make implicit missing values explicit with complete(); 
# make explicit missing values implicit with drop_na(); 
# replace missing values with next/previous value with fill(), 
# or a known value with replace_na().

sample <- combined[1:10, c('ipno', 'birth_wt', 'gest')]

#combined[1:10, c(2, 6, 3)]

# dataset[rows, cols, ....]


sample %>% 
  select(birth_wt) %>% 
  t() %>% 
  t()


# gather()
# syntax

gather(data, key = "key", value = "value")

gather(sample, key = "Variable", value = "Value", -ipno)

gather(sample, key = "Variable", value = "Value")

sample %>% 
  select(-ipno) %>% 
  gather(key = "Variable", value = "Value")

# pivot_longer()
# syntax

pivot_longer(data, c(x, y, z), names_to = "key", values_to = "value")

sample$gest <- as.integer(sample$gest)

pivot_longer(sample, c('birth_wt', 'gest'),  names_to = "Variables", values_to = "Value")

adms_data <- tibble(
  Hospital = c("Hosp A", "Hosp B"),
  adms_2019 = c(1000, 500),
  adms_2020 = c(1200, 600),
  adms_2021 = c(1500, 800)
)

# adms_data <- data.frame(
#   Hospital = c("HospA", "HospB"),
#   y2019 = c(1000, 500),
#   y2020 = c(1200, 600),
#   y2021 = c(1500, 800)
# )

# pivot the data using pivot_longer()

adms_data_long <- pivot_longer(
  data = adms_data,
  cols = c(adms_2019, adms_2020, adms_2021),
  names_to = "Year",
  values_to = "Admissions"
)

library(ggplot2)

ggplot(data = adms_data_long, aes(x = Year, y = Admissions, fill = Hospital)) +
  geom_col(position = "stack")


ggplot(data = adms_data_long, aes(x = Year, y = Admissions, fill = Hospital)) +
  geom_col(position = "dodge")


# melt() - reshape2, data.table
# syntax
melt(data, id.vars, measure.vars, variable.name = "variable", value.name = "value")

setDT(sample)

long_data <-
  melt(sample,
       id.vars = 'ipno',
       variable.name = "Variable",
       value.name = "Value")

# >>>>>>>>>>>>>>>>>> Making data wide from long <<<<<<<<<<<<<<<<<<<<<<<<<<<<<
# spread()
# syntax
spread(data, key, value)

spread(long_data, Variable, Value)

df <-
  data.frame(month = c(seq(as.Date("2020-01-01"), as.Date("2020-12-01"), by = 'month')),
             performance = c(90, 45, 50, 55, 87, 65, 29, 55, 66, 90, 77, 19))


wide_data <- spread(df, month, performance)


# pivot_wider()
# syntax

wider <- pivot_wider(df, names_from = 'month', values_from = "performance")


# separate()
# syntax

df$month <- as.Date(df$month)
separate(df, col = month, into = c("day", "month", "year"), sep = "-")

names <- data.frame(name = c("John Doe", "Jane Smith", "Bob Johnson"))

# separate the name column into first_name and last_name columns
names <- separate(names, col = name, into = c("first_name", "last_name"), sep = " ")

payments <- data.frame(pay = c("KSh/1000", "USD/234", "Yuan/850"))

payments <- separate(payments, col = pay, into = c("Currency", "Amount"), sep = "/")


# unite()

# syntax
unite(data, col, ..., sep = "_", remove = TRUE, na.rm = FALSE)

unite(payments, col = comb, sep = " ")


# complete()

# syntax
complete(data, ..., fill = list(), explicit = TRUE)

alphabets <- data.frame(letter = c("a", "b", "d", "f", "h"))

# use complete() to fill in missing letters
alphabets_complete <- complete(alphabets, letter = letters)


# complete missing months

months = c("2020-01-01", "2020-02-01", "2020-03-01", "2020-06-01", "2020-07-01",
          "2020-08-01", "2020-09-01", "2020-10-01", "2020-11-01", "2020-12-01")

seq.Date(from = min(as.Date(months)), to = max(as.Date(months)), by = "month")

months_names <- data.frame(month = c("January", "February", "April", "May", "December"))

months_complete <- complete(months_names, month = month.name)


