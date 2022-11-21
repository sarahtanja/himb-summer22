# load packages
library(tidyverse)
library(viridis)
library(multcompView)
library(plotrix)
library(readxl)
library(writexl)
library(lubridate)
library(ggrepel)

# set working directory
setwd("C:/Users/ssdon/OneDrive/Documents/himb-summer22")

# import data
cleavage <- read_csv(file="data/cleavage-n3.csv")

# create column for fertilization 
# the percentage of eggs from each treatment successfully reaching cleavage 4-hours post-fertilization
# cleavage is a simple visual proxy indicating fertilization has occurred successfully
cleavage$fertilization <- (cleavage$cleave_count/cleavage$egg_count)*100

# note that there was no fertilization in the vials crossed between colony 1 and colony 2 
# We have reason to suspect that fertilization did not occur because of low genetic diversity 
# it is possible that collected colonies 1 and 2 were the same genotype
# for this reason, we exclude them from the analysis
# filter for just wild crossed bundles 
wild.cleavage <- filter(cleavage, colony_a == "wild", colony_b == "wild")
# select only the columns we will be working with
wild.cleavage <- wild.cleavage[ , c("treatment","pae_ugL", "egg_count",
                                    "cleave_count", "fertilization")]
# relevel treatment factor
# convert treatment from character to factor
wild.cleavage <- wild.cleavage %>% 
  mutate(treatment=factor(treatment)) %>% 
  mutate(treatment=fct_relevel(treatment,c("control","low","mid", "high", "peak"))) %>%
  arrange(treatment)

levels(wild.cleavage$treatment)

# we use all 'wild' egg-sperm bundle crosses from the June M. capitata spawn
# 'wild' crosses are egg-sperm bundles that were collected from the lagoon, parents
# response variable is whether the eggs visibly reached initial cleavage 
# ergo I name this small dataframe 'wild.cleavage' ;)
summary(wild.cleavage)
head(wild.cleavage)

# we first need to make the Tukey letters indicating significant differences 
# (a, ab, b)  
# code from: https://statdoe.com/barplots-for-three-factors/

# fertilization is the response variable
# treatment (or pae_ugL) is the explanatory variable

# ANOVA
# Compute the analysis of variance
anova <- aov(fertilization ~ treatment, data = wild.cleavage)
summary(anova)

# Tukey's test and compact letter display (cld)
Tukey <- TukeyHSD(anova)
Tukey
cld <- multcompLetters4(anova, Tukey)
cld <- as.data.frame.list(cld$`treatment`)
cld$treatment <- c("control","high","mid", "peak", "low")
cld

# Table with the mean, the standard deviation 
dt <- group_by(wild.cleavage, treatment) %>%
  summarise(fert_mean = mean(fertilization), sd = sd(fertilization))
dt

# add the letters indications significant differences for each treatment (cld)
df = dt %>% inner_join(cld, by="treatment")
df

print(df)


#wild.cleavage$Tukey <- factor(c('','','a','b','b','b','b','b','b','ab','ab','ab','b','b','b'))

# plot
wild.cleavage %>%
  
  # Add a column called 'type': we want to highlight the "control" group differently
  mutate(type = ifelse(treatment == "control", "Highlighted", "Normal")) %>%
  
  # build the boxplot
  ggplot(aes(
    x = factor(pae_ugL),
    y = fertilization,
    fill = type,
    alpha = type
    )) +
  #xlab('concentration of phthalates in ug/L') +
  #ylab('% of M. capitata eggs reaching initial cleavage') +
  ylim(0, 100) +
  geom_boxplot(width = 0.2) +
  scale_fill_manual(values=c("#69b3a2", "orange")) +
  scale_alpha_manual(values=c(0.8,0.8)) +
  geom_point() +
  theme(
    legend.position = "none",
    axis.ticks = element_blank(),
    axis.text = element_text(face="bold", size = 20),
    axis.title.x=element_blank(),
    axis.title.y=element_blank(),
    axis.line = element_line(colour = "grey50"),
    panel.grid = element_line(color = "#b4aea9"),
    panel.grid.minor = element_blank(),
    panel.grid.major.x = element_blank(),
    panel.grid.major.y = element_line(linetype = "dashed"),
    panel.background = element_rect(fill = "#fbf9f4", color = "#fbf9f4"),
    plot.background = element_rect(fill = "#fbf9f4", color = "#fbf9f4")
  )





#