

library(tidyverse)
library(lubridate)

## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

#creation of DF for the plot: selection of variables, sum of emission by year
dfplot <- NEI %>% 
    select(Emissions,year) %>% 
    group_by(year) %>% 
    summarize_all(sum) %>% 
    ungroup()

png(filename = "./Plot1.png", width = 480, height = 480, units = "px")

plot(dfplot, 
     type = "b",
     pch = 20,
     col = "blue",
     xlab = "year",
     main = expression('Total PM'[2.5]*" Emissions in the United States from 1999 to 2008"),
     ylab = "tons")


dev.off()