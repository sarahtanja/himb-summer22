

# load packages
library(tidyverse)
library(ggplot2)
install.packages("viridis")
library(viridis)

# set working directory
setwd("C:/Users/ssdon/OneDrive/Documents/himb-summer22")

# practice plotting
n <- 6

pae_dose_ugL <- c(rep(0, n), 
                  rep(0.5, n),
                  rep(5, n),
                  rep(50, n),
                  rep(150, n)
)

fert <- c(rnorm(n=n, mean=100, sd=4), 
          rnorm(n=n, mean=50, sd=9),
          rnorm(n=n, mean=60, sd=1),
          rnorm(n=n, mean=70, sd=2),
          rnorm(n=n, mean=40, sd=6)
)

df <- data.frame(pae_dose_ugL,fert)


ggplot(df, aes(x=pae_dose_ugL, y=fert)) +
  geom_point() +
  scale_x_continuous(trans='log10')

