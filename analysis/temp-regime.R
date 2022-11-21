# temp regime taken from HOBO loggers

# load packages
library(tidyverse)
library(ggplot2)
library(lubridate)

# set working directory
setwd("C:/Users/ssdon/OneDrive/Documents/himb-summer22")

# import data
templog <- read_csv(file="data/pool-party-test-hobo-temp-log.csv",
                    col_names = c("log", "datetime", "tempC", "lux"),
                    skip = 1)

summary(templog)

# check to see if date-time is data type date-time using str()
str(templog$datetime)

# find timezone name for Hawaii
OlsonNames()

## Use "Pacific/Honolulu" as timezone!

# because R imported the date-time as a chr or character, 
# parse to date-time using lubridate
templog$datetime <- mdy_hms(templog$datetime, tz="Pacific/Honolulu")

# recheck date-time format, should show POSIXct as data type!
str(templog$datetime)

# plot data
ggplot(templog, 
       aes(x = datetime, y = tempC)) +
  geom_line()

# remove data from when logger was taken out of water
templog <- templog[-c(851:854), ]

# plot again
ggplot(templog, 
       aes(x = datetime, y = tempC)) +
  geom_line()

summary(templog)

# min, max, mean by hour of the day
templog <- templog %>% group_by(hour(datetime)) %>% mutate(min = min(tempC), max = max(tempC), mean = mean(tempC))

# mean temp by hour of the day



