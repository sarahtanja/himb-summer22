##### This file is just for graphing the stupid complicated 
#graphs with the Tukey letters

#code from: https://statdoe.com/barplots-for-three-factors/

library(tidyverse)
library(plotrix)
library(readxl)
library(writexl)
library(lubridate)
library(multcompView)
library(ggrepel)

# dataframe is wild.cleavage
summary(wild.cleavage)

# ferrtilization is the response variable
# treatment or pae_ugL is the explanatory variable

# ANOVA
# Compute the analysis of variance
anova <- aov(fertilization ~ treatment, data = wild.cleavage)
summary(anova)

# Tukey's test and compact letter display (cld)
Tukey <- TukeyHSD(anova)
cld <- multcompLetters4(anova, Tukey)
cld

# Table with the mean, the standard deviation 
dt <- group_by(wild.cleavage, treatment) %>%
  summarise(fert_mean = mean(fertilization), sd = sd(fertilization))
dt

# add the letters indications significant differences for each treatment (cld)
?as.data.frame.list
cld <- as.data.frame.list(cld$`treatment`)
cld
dt$Tukey <- cld$Letters

print(dt)


ggplot(dt, aes(x=treatment, y=fert_mean, 
                 group = as.factor(treatment), color = as.factor(treatment))) + 
  geom_line() +
  geom_point() + 
  xlab("Plasticizer") + 
  ylab(expression(paste("Fertilization"))) +
  theme_classic() +
  #facet_grid(. ~ Site) +
  theme(strip.background = element_rect(fill = NA, color = NA)) +
  guides(color=guide_legend(title="Response Curve")) +
  geom_text_repel(aes(label=Tukey), size = 2.5, color = "Gray35",
            family = "Helvetica", show.legend = FALSE, box.padding = 0.13, point.padding = 2) 

ggsave("Figures/net_photo.jpeg", width = 6, height = 4, units = "in",
       dpi=500)


