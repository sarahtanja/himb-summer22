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

#start wtih 'data' dataframe already loaded in

# analysis of variance
anova <- aov(Net.photosynthesis ~ Temperature.treatment*pH.treatment*Site, data = data)
summary(anova)

# Tukey's test and compact letter display
Tukey <- TukeyHSD(anova)
cld <- multcompLetters4(anova, Tukey)

# Table with the mean, the standard deviation and the letters 
#indicates significant differences for each treatment
dt <- vals %>% #get data in the same order as Tukey output
  arrange(desc(mean.net))
cld <- as.data.frame.list(cld$`Temperature.treatment:pH.treatment:Site`)
dt$Tukey <- cld$Letters

print(dt)


ggplot(dt, aes(x=Actual.temperature.experiment.tank, y=mean.net, 
                 group = as.factor(pH.treatment), color = as.factor(pH.treatment))) + 
  geom_errorbar(aes(ymin = mean.net - se.net, 
                    ymax = mean.net + se.net), width = 0.6) +
  geom_line() +
  geom_point() + 
  xlab("Temperature (°C)") + 
  ylab(expression(paste("Net photosynthetic rate (",mu,"mol/min/g)"))) +
  theme_classic() +
  facet_grid(. ~ Site) +
  theme(strip.background = element_rect(fill = NA, color = NA)) +
  guides(color=guide_legend(title="pH treatment")) +
  geom_text_repel(aes(label=Tukey, y = mean.net + se.net + 0.1), size = 2.5, color = "Gray35",
            family = "Helvetica", show.legend = FALSE, box.padding = 0.13, point.padding = 2) 
ggsave("Figures/net_photo.jpeg", width = 6, height = 4, units = "in",
       dpi=500)


