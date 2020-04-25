

library(tidyverse)
library(lubridate)
library(ggplot2)

## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

#creation of DF for the plot: subsetting "fips"= Baltimore City, selection of variables, sum of emission by year and type
dfplot <- NEI %>% 
    subset(fips=="24510")%>% 
    select(Emissions,year,type) %>% 
    group_by(year, type) %>% 
    summarize_all(sum) %>% 
    ungroup()

png(filename = "./Plot3.png", width = 480, height = 480, units = "px")

ggplot(dfplot, aes(year, Emissions, colour = type)) +
    geom_line() +
    geom_point() +
    theme_light() +
    theme(legend.position="bottom") +
    labs(title = expression('Total PM'[2.5]*" Emissions in Baltimore City, Maryland from 1999 to 2008"), x = "year", y = "tons")


dev.off()
