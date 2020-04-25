

library(tidyverse)
library(lubridate)
library(ggplot2)

## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")


#creation of DF for the plot: subsetting "fips"= Baltimore City and "type"= from motor vehicle, selection of variables, sum of emission by year
dfplot <- NEI %>% 
    subset(fips=="24510" & type=="ON-ROAD")%>% 
    select(Emissions,year) %>% 
    group_by(year) %>% 
    summarize_all(sum) %>% 
    ungroup()


png(filename = "./Plot5.png", width = 480, height = 480, units = "px")

plot(dfplot, 
     type = "b",
     pch = 20,
     col = "blue",
     xlab = "year",
     main = "Total Emissions from Motor Vehicle in Baltimore City",
     ylab = "tons")

dev.off()

