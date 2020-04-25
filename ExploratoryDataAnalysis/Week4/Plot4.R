

library(tidyverse)
library(lubridate)
library(ggplot2)

## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")



#finding the SCC for coal combustion-related
Coal <- SCC[grep("Comb.*Coal", SCC$Short.Name), "SCC"]

#creation of DF for the plot: subsetting "SCC"= coal combustion-related, selection of variables, sum of emission by year
dfplot <- NEI[NEI$SCC %in% Coal, ] %>% 
    select(Emissions,year) %>% 
    group_by(year) %>% 
    summarize_all(sum) %>% 
    ungroup()


png(filename = "./Plot4.png", width = 480, height = 480, units = "px")

plot(dfplot, 
     type = "b",
     pch = 20,
     col = "blue",
     xlab = "year",
     main = "Total Emissions from Coal Combustion-Related Sources",
     ylab = "tons")

dev.off()
