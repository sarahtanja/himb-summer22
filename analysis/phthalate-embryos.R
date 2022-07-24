# load packages
library(tidyverse)
library(ggplot2)
library(viridis)

# set working directory
setwd("C:/Users/ssdon/OneDrive/Documents/himb-summer22")

# import data
cleavage <- read_csv(file="cleavage.csv")

# filter for just wild crossed bundles 
wild.cleavage <- filter(cleavage, colony_a == "wild", colony_b == "wild")

# violin plot on continuous x axis 
ggplot(wild.cleavage, aes(x=factor(pae_ugL), 
                     y=percent_response)) +
  labs(title = 'A little is a lot \n Phthalates reduce fertilization of M. capitata coral eggs: \n another example of non-monotonic response to endocrine disrupting chemicals') +
  xlab('concentration of phthalates in ug/L') +
  ylab('% of M. capitata eggs reaching initial cleavage') +
  ylim(0, 100) +
  geom_violin() +
  geom_point() +
  theme_minimal() +
  theme(legend.position = "bottom")

# box plot on continuous x axis 
ggplot(wild.cleavage, aes(x=factor(pae_ugL), 
                          y=percent_response)) +
  labs(title = 'A little is a lot \n Phthalates reduce fertilization of M. capitata coral eggs: \n another example of non-monotonic response to endocrine disrupting chemicals') +
  xlab('concentration of phthalates in ug/L') +
  ylab('% of M. capitata eggs reaching initial cleavage') +
  ylim(0, 100) +
  geom_boxplot() +
  geom_point() +
  theme_minimal() +
  theme(legend.position = "bottom")

# ANOVA
# Compute the analysis of variance
res.aov <- aov(percent_response ~ treatment, data = wild.cleavage)
# Summary of the analysis
summary(res.aov)

TukeyHSD(res.aov)
