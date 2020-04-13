library(tidyverse)
library(lubridate)
library(data.table)


df <- read.table("ExploratoryDataAnalysis/Week1/household_power_consumption.txt",
                 header = TRUE, 
                 sep = ";", 
                 na.strings = "?",
                 colClasses = c("character","character", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric"))


df <- df %>% 
    mutate(DateTime=as.POSIXct(strptime(paste(Date, Time), format="%d/%m/%Y %H:%M:%S"))) %>% 
    mutate(Date=as.Date(strptime(Date, "%d/%m/%Y"))) %>% 
    subset(Date>="2007-02-01" & Date<="2007-02-02")


hist(df$Global_active_power, 
     col = "red", 
     main = "Global Active Power",
     xlab="Global Active Power(kilowatts)",
     ylab="Frequency")
dev.copy(png, file = "ExploratoryDataAnalysis/Week1/Plot1.png")  ## Copy my plot to a PNG file
dev.off()