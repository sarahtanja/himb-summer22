# load packages
library(tidyverse)
library(ggplot2)
library(viridis)

# set working directory
setwd("C:/Users/ssdon/OneDrive/Documents/himb-summer22")

# import data
pae <- read_csv(file="pae-dosing.csv")

# filter for just cleavage phase 
cleavage <- filter(pae, phase == "cleave", colony_a == "wild")

# violin plot on continuous x axis 
ggplot(cleavage, aes(x=factor(pae_ugL), 
                     y=percent_response)) +
  xlim(0, 160) +
  ylim(0, 100) +
  geom_violin(aes(scale = "area",
                  fill = pae_ugL)) +
  geom_point() +
  theme_minimal() +
  theme(legend.position = "bottom")
  #scale_x_continuous(name = 'concentration of phthalates in ug/L') +
  #scale_y_continuous(name = '% of M. capitata eggs reaching initial cleavage')


