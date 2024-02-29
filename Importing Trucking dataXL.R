library(readxl)
library(dplyr)
library(tidyverse)
library(tidyr)
library(ggplot2)

rm(list = ls())
#setting up working directory
setwd('~/Documents/DATA/Data 332/NP_EX_1-2.xlsx')

# df_truck <- read_excel('~/Documents/DATA/Data 332/NP_EX_1-2.xlsx' , sheet = 2, skip = 3, .name_repair = 'universal')
df_truck <- read_excel('~/Documents/DATA/Data 332/NP_EX_1-2.xlsx', sheet = 2, skip = 3, .name_repair = 'universal')

#selecting columns 
df  <- df_truck[, c(4:15)]
#deselecting columns
df <- subset (df , select = -c(...10))

#getting difference in days within columns 
date_min <- min(df$Date)
date_max <- max(df$Date)

number_of_days_on_the_road <- date_max - date_min
print(number_of_days_on_the_road)

days <- difftime(max(df$Date), min(df$Date))
print(days)
number_of_days_recorded <- nrow(df)

total_hours <- sum(df$Hours )
average_hours_per_day_rec <- round(total_hours / number_of_days_recorded, digits = 3)
print(average_hours_per_day_rec)

df$fuel_cost <- df$Gallons * df$Price.per.Gallon

# to get total fuel expenses 
df$total_cost <- df$Misc + df$Tolls + df$fuel_cost
print(df$total_cost)

# to separate the city state out of the table (splitting)
df[c('warehouse', 'city_state')] <- str_split_fixed(df$Starting.Location, ',', 2)
view(df)

df$total_gallons_consumed <- sum(df$Gallons)
print(df$total_gallons_consumed)

df$total_miles_driven <- sum(df$Odometer.Ending - df$Odometer.Beginning)
print(df$total_miles_driven)

df$miles_per_gallon <- df$total_miles_driven / df$total_gallons_consumed
print(df$miles_per_gallon)

df$total_cost_per_mile <- df$total_cost / df$total_miles_driven 
print(df$total_cost_per_mile)

df[c('warehouse', 'starting_city_state')] <- str_split_fixed(df$Starting.Location, ',', 2)

#removing white space 
df$ending_city_state <- trimws(df$ending_city_state)

df$starting_city_state <- gsub(',', "", df$starting_city_state)

# to separate city and state , df[c('col1', 'col2')] <- str_split_fixed(df$city_state, ' ' , 2)
df_starting_pivot <- df %>%
  group_by(starting_city_state) %>%
  summarize(count = n(),
            mean_size_hours = mean(Hours, na.rm = TRUE),
            sd_hours = sd(Hours, na.rm = TRUE),
            total_hours = sum(Hours, na.rm = TRUE),
            total_gallons = sum(Gallons, na.rm = TRUE)
  )

ggplot(df_starting_pivot, aes(x = starting_city_state, y = count)) +
  geom_col() + theme(axis.text = element_text(angle = 45, vjust = .5, hjust = 1))

df[c('end_location', 'ending_city_state')] <- str_split_fixed(df$Delivery.Location, ',', 2)
view(df)


df_ending_pivot <- df %>%
  group_by(ending_city_state) %>%
  summarize(count = n(),
            mean_size_hours = mean(Hours, na.rm = TRUE),
            sd_hours = sd(Hours, na.rm = TRUE),
            total_hours = sum(Hours, na.rm = TRUE),
            total_gallons = sum(Gallons, na.rm = TRUE)
  )

ggplot(df_ending_pivot, aes(x = ending_city_state, y = count)) +
  geom_col() + theme(axis.text = element_text(angle = 45, vjust = .5, hjust = 1))
