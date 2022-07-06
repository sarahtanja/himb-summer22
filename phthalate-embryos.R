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
  labs(title = 'A little is a lot \n Phthalates reduce fertilization of M. capitata coral eggs: \n another example of non-monotonic response to endocrine disrupting chemicals') +
  xlab('concentration of phthalates in ug/L') +
  ylab('% of M. capitata eggs reaching initial cleavage') +
  ylim(0, 100) +
  geom_violin() +
  geom_point() +
  theme_minimal() +
  theme(legend.position = "bottom")


