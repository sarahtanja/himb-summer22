# load packages
library(tidyverse)
library(ggplot2)
library(viridis)
library(dplyr)
library(hrbrthemes)
library(ggstatsplot)

# set working directory
setwd("C:/Users/ssdon/OneDrive/Documents/himb-summer22")

# import data
cleavage <- read_csv(file="data/cleavage-n3.csv")
summary(cleavage)

# create column for fertilization
cleavage$fertilization <- (cleavage$cleave_count/cleavage$egg_count)*100

# pair down data to just the columns we are using for this analysis

# note that there was no fertilization in the vials crossed between colony 1 and colony 2
# We have reason to suspect that fertilization did not occur because of low genetic diversity
# it is possible that collected colonies 1 and 2 were the same genotype
# for this reason, we exclude them from the analysis
# filter for just wild crossed bundles 
wild.cleavage <- filter(cleavage, colony_a == "wild", colony_b == "wild")
wild.cleavage <- wild.cleavage[, c("treatment", "pae_ugL", "egg_count","cleave_count", "fertilization")]

#convert treatment from character to factor
wild.cleavage <- wild.cleavage %>% 
  mutate(treatment=factor(treatment)) %>% 
  mutate(treatment=fct_relevel(treatment,c("control","low","mid", "high", "peak"))) %>%
  arrange(treatment)

levels(wild.cleavage$treatment)

# violin plot  
ggplot(wild.cleavage, aes(x=factor(pae_ugL), 
                          y=fertilization,
                          fill=treatment)) +
  labs(title = 'A little is a lot \n Phthalates reduce fertilization of M. capitata coral eggs: \n another example of non-monotonic response to endocrine disrupting chemicals') +
  xlab('concentration of phthalates in ug/L') +
  ylab('% of M. capitata eggs reaching initial cleavage') +
  ylim(0, 100) +
  geom_violin(width=1.4, color="grey") +
  geom_boxplot(width=0.1, color="grey", alpha=0.2) +
  scale_fill_viridis(alpha=.6, discrete = TRUE) +
  geom_point()

# box plot 
# Add a column called 'type': do we want to highlight the group or not?
wild.cleavage %>%
  
  mutate(type = ifelse(treatment == "control", "Highlighted", "Normal")) %>%
  
  # build the boxplot
  ggplot(aes(
    x = factor(pae_ugL),
    y = fertilization,
    fill = type,
    alpha = type
  )) +
  xlab('concentration of phthalates in ug/L') +
  ylab('% of M. capitata eggs reaching initial cleavage') +
  ylim(0, 100) +
  geom_boxplot(width = 0.2) +
  scale_fill_manual(values=c("#69b3a2", "orange")) +
  scale_alpha_manual(values=c(0.4,0.9)) +
  geom_point() +
  theme(
    legend.position = "none",
    axis.ticks = element_blank(),
    axis.line = element_line(colour = "grey50"),
    panel.grid = element_line(color = "#b4aea9"),
    panel.grid.minor = element_blank(),
    panel.grid.major.x = element_blank(),
    panel.grid.major.y = element_line(linetype = "dashed"),
    panel.background = element_rect(fill = "#fbf9f4", color = "#fbf9f4"),
    plot.background = element_rect(fill = "#fbf9f4", color = "#fbf9f4")
  )
  

# ANOVA
# Compute the analysis of variance
res.aov <- aov(fertilization ~ treatment, data = wild.cleavage)
# Summary of the analysis
summary(res.aov)

TukeyHSD(res.aov)