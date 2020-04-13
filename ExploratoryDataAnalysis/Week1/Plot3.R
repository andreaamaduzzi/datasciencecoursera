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

png(file = "ExploratoryDataAnalysis/Week1/Plot3.png")

plot(df$Sub_metering_1~df$DateTime, 
     type = "l",
     xlab="",
     ylab="Energy sub metering")
lines(df$Sub_metering_2~df$DateTime, 
      type = "l",
      col="red")
lines(df$Sub_metering_3~df$DateTime, 
      type = "l",
      col="blue")
legend("topright",
       lty=1,lwd=1,
       col=c("black","red","blue"),
       legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))

dev.off()
