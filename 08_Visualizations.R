

###################################################################

## TOPIC: DATA VISUALIZATION
## AFROHUN R VOP 
## WEDNESDAY, 18/05/2023
## JOHN WAINAINA
## Email: </> phomwangi@gmail.com

##################################################################

## > SESSION OUTLINE
# > visualization with Base R
# > visualization with ggplot2 R


# Base R

# 1. Parameters
# 2. Plot attributes
        # xlab: specifies the x-axis label of the plot
        # ylab: specifies the y-axis label
        # main: titles your graph
        # pch: specifies the symbology of your graph
        # col: specifies the colors for your graph.
# 3. The legend


par(mfrow = c(1, 2), mar = c(5,5,4,1)) 

# basic plot
iris <- iris

# structure

<function>(x = x-axis, y = y-axis)


plot(iris$Sepal.Length, iris$Sepal.Width) 

?plot

# specify labels and others
plot(iris$Sepal.Length, iris$Sepal.Width,
     type = "p", # scatter plot - default
     pch = 20,
     xlab = "Length",
     ylab = "Width",
     main = "Petal Length vs Petal Width") 

# specify color of plotted groups
plot(iris$Sepal.Length, iris$Sepal.Width,
     type = "p", # scatter plot - default
     pch = 20,
     xlab = "Length",
     ylab = "Width",
     main = "Petal Length vs Petal Width",
#col = 'purple'#,
col = ifelse(iris$Species == "setosa","coral1",
           ifelse(iris$Species == "virginica","cyan4",
                  ifelse(iris$Species ==  "versicolor", "darkgoldenrod2", "grey")))
)


# add legend

plot(head(iris$Sepal.Length), head(iris$Sepal.Width),
     type = "p", # scatter plot - default
     pch = 9,
     xlab = "Length",
     ylab = "Width",
     main = "Petal Length vs Petal Width",
     #col = 'steelblue'#,
     col=ifelse(iris$Species == "setosa","coral1",
                ifelse(iris$Species == "virginica","cyan4",
                       ifelse(iris$Species ==  "versicolor",
                              "darkgoldenrod2", "grey"))),
legend("bottomright", 
       c("setosa","virginica", "versicolor"),
       col = c("coral1","cyan4", "darkgoldenrod2"), 
       pch= c(20))
)

# Specify/format colors, fonts etc...

# font.lab: specifies the font of your labels
# col.lab: specifies the color of your labels
# font.main: specifies the font of your main title
# col.main: specifies the color of your main title

plot(iris$Sepal.Length, iris$Sepal.Width,
     type = "p", # scatter plot - default
     pch = 9,
     font.lab = 7,
     col.lab = "azure4",
     main = "Petal Width vs Petal Length",
     # font.main = 7,
     # col.main = "black",
     # xlab = "Length",
     # ylab = "Width",
     main = "Petal Length vs Petal Width",
     #col = 'steelblue'#,
     col=ifelse(iris$Species == "setosa","coral1",
                ifelse(iris$Species == "virginica","cyan4",
                       ifelse(iris$Species ==  "versicolor",
                              "darkgoldenrod2", "grey"))),
     legend("bottomright", 
            c("setosa","virginica", "versicolor"),
            col = c("coral1","cyan4", "darkgoldenrod2"), 
            pch= c(20))
)

# Other types of plots

# histogram - continuous data

hist(iris$Sepal.Length)

# boxplot - continuous data

boxplot(iris$Sepal.Length)

# by group

boxplot(iris, Sepal.Length ~ Petal.Width)


# >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

## ggplot2 package

# Data: The raw data that you want to plot.
# Geometries geom_: The geometric shapes used to visualize the data.
# Aesthetics aes(): Aesthetics pertaining to the geometric and statistical objects, like colour, size, shape, location, and transparency
# Coordinate system coord_: used to organize the geometric objects by mapping data coordinates
# Facets facet_: a grid of plots is displayed for groups of data.
# Visual themes theme(): The overall visual elements of a plot, 
# like grids & axes, background, fonts, and colours.

# preliquisites

#install.packages('ggplot2')
library(ggplot2)

# structure

<function>(data = <data>, mapping = aes(<x>, <y>)) +
  geometry <geom_>
  
ggplot(data = data, mapping = aes(x = x, y = y)) +
  geom_...()

ggplot(data = iris, mapping = aes(x = Sepal.Length, y = Sepal.Width)) + 
  geom_point()

# Add title and customize axes labels

ggplot(data = iris, mapping = aes(Sepal.Length, Sepal.Width)) + 
  geom_point() +
  labs(title = "Sepal Length vs Sepal Width",
       x = 'Sepal Length',
       y = 'Sepal Width')

# Color by group - use color 

ggplot(data = iris, mapping = aes(x = Sepal.Length, y = Petal.Length, color = Species)) + 
  geom_point() +
  labs(title = "Sepal Length vs Sepal Width",
       x = 'Sepal Length',
       y = 'Sepal Width')

# Organize legend - use - theme()

ggplot(data = iris, mapping = aes(x = Sepal.Length, y = Petal.Length, color = Species)) + 
  geom_point() +
  labs(title = "Sepal Length vs Sepal Width",
       x = 'Sepal Length',
       y = 'Sepal Width') +
  theme(legend.position = 'top',
       legend.title = element_blank(),
       legend.text = element_text(size = 18, face = 'bold'),
       plot.title = element_text(size = 25, 
                                 face = 'bold', 
                                 hjust = 0.5),
       text = element_text(family = 'Times New Roman')
        )

library(extrafont)
# Adding attributes - shape

ggplot(data = iris, mapping = aes(x = Sepal.Length, y = Petal.Length, color = Species)) + 
  geom_point(shape = 3) +
  labs(title = "Sepal Length vs Sepal Width",
       x = 'Sepal Length',
       y = 'Sepal Width')

 
# establishing relationship between the variables - geom_smooth()

ggplot(data = iris, mapping = aes(x = Sepal.Length, y = Petal.Length, color = Species)) + 
  geom_point(shape = 10) +
  geom_smooth(method = 'lm', se = FALSE) + # standard error around model line
  labs(title = "Sepal Length vs Sepal Width",
       x = 'Sepal Length',
       y = 'Sepal Width')

# Bar Plots > categorical data

ggplot(mpg, aes(x = as.factor(cyl))) +
  geom_bar()



# Histograms > continuous distribution of data

ggplot(mpg, aes(x = hwy)) +
  geom_histogram()


# Pie chart

df <- table(mpg$class) %>% data.frame() 

names(df) <- c("Class", "Freq")

pie_chart <-
  ggplot(df, aes(x = "", y = Freq, fill = Class)) +
    geom_bar(width = 1, stat = "identity")

pie_chart + coord_polar(theta = "y", start = 0)


# >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

# SATURDAY 20TH MAY 2023


# load packages

library(dplyr)
library(data.table)
library(tidyverse)
library(extrafont)
loadfonts(device = "win")

# load the dataset

covid <- read_csv(file = here::here(getwd(), "Datasets", "COVID-19", "covid_19_clean_complete.csv"))

#> Rename cols - multiple ways of doing it

names(covid)[c(1,2,10)] <- c('Province','Country', 'Region')

copy <- covid

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



library(ggplot2)


ggplot(region_summ, aes(fill=Indicator, y=`%`, x=Region)) + 
  geom_bar(position="stack", stat="identity") +
  ggtitle("COVID19 by Regions - Stacked")

ggplot(region_summ, aes(fill=Indicator, y=`%`, x=Region)) + 
  geom_bar(position="dodge", stat="identity") +
  ggtitle("COVID19 by Regions - Dogded")


# 4)	Visualize using ggplot2: 
# Plot daily number of covid cases and deaths for the 7 months (all period dataset) for each:
# i) Globally
# ii)	Region 
# iii) Country



# i) Globally

globally <- 
  copy %>% 
  group_by(Date) %>% 
  dplyr::summarise(
    Confirmed = sum(Confirmed, na.rm = T),
    Deaths = sum(Deaths, na.rm = T),
    Recovered = sum(Recovered, na.rm = T),
    Active = sum(Active, na.rm = T)) 


ggplot(data = globally, mapping = aes(x = Date, y = Confirmed)) +
  geom_line(aes(color = 'red')) +
  geom_point(size = 0.9) +
  theme_bw() +
  scale_x_date(date_breaks = '1 week', date_labels = '%b \n %d') +
  scale_y_continuous(breaks = seq(0, 43000000, by = 500000)) +
  labs(title = "Global Daily Covid-19 Cases",
       x = "Date",
       y = "Confirmed Cases") +
  theme(text = element_text(face = 'bold', family = 'Candara'),
        axis.title = element_text(size = 15),
        plot.title = element_text(size = 23, hjust = 0.5),
        legend.position = 'none')


# ii)	Region

regional <- 
  copy %>% 
  group_by(Date, Region) %>% 
  dplyr::summarise(
    Confirmed = sum(Confirmed, na.rm = T),
    Deaths = sum(Deaths, na.rm = T),
    Recovered = sum(Recovered, na.rm = T),
    Active = sum(Active, na.rm = T)) 

long_regional <- regional %>% 
  pivot_longer(., 
               cols = c('Confirmed', 'Deaths', 'Recovered', 'Active'), 
               names_to = "Indicator",
               values_to = "Counts")


ggplot(data = regional, mapping = aes(x = Date, y = Confirmed, color = Region)) +
  geom_line() +
  geom_point(size = 0.9) +
  theme_bw() +
  scale_x_date(date_breaks = '1 week', date_labels = '%b \n %d') +
  scale_y_continuous(breaks = seq(0, 43000000, by = 500000)) +
  facet_wrap(~ Region)
labs(title = "Global Daily Covid-19 Cases",
     x = "Date",
     y = "Confirmed Cases") +
  theme(text = element_text(face = 'bold', family = 'Candara'),
        axis.title = element_text(size = 15),
        plot.title = element_text(size = 23, hjust = 0.5),
        legend.position = 'none') 


long_regional <- regional %>% 
  pivot_longer(., 
               cols = c('Confirmed', 'Deaths', 'Recovered', 'Active'), 
               names_to = "Indicator",
               values_to = "Counts")

ggplot(data = long_regional, mapping = aes(x = Date, y = Counts, color = Indicator)) +
  geom_line() +
  geom_point(size = 0.9) +
  theme_bw() +
  scale_x_date(date_breaks = '1 week', date_labels = '%b \n %d') +
  scale_y_continuous(breaks = seq(0, 43000000, by = 500000)) +
  facet_wrap(~ Region)
labs(title = "Global Daily Covid-19 Cases",
     x = "Date",
     y = "Confirmed Cases") +
  theme(text = element_text(face = 'bold', family = 'Candara'),
        axis.title = element_text(size = 15),
        plot.title = element_text(size = 23, hjust = 0.5),
        legend.position = 'none')


