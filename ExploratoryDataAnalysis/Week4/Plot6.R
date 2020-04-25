

library(tidyverse)
library(lubridate)
library(ggplot2)

## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")


#creation of DF for the plot: subsetting "fips"= Baltimore City or Los Angeles and "type"= from motor vehicle, selection of variables, sum of emission by year and fips
dfplot <- NEI %>% 
    subset(fips=="24510" | fips=="06037")%>% 
    subset(type=="ON-ROAD") %>% 
    select(Emissions,year, fips) %>% 
    group_by(year, fips) %>% 
    summarize_all(sum) %>% 
    ungroup()%>% 
    spread(.,fips,Emissions)

colnames(dfplot) <- c( "year", "Los Angeles", "Baltimore") #naming the variables

rng=range(dfplot$Baltimore,dfplot$`Los Angeles`) #creations of range for first plot


#creation of DF for the plot: subsetting "fips"= Baltimore City or Los Angeles and "type"= from motor vehicle, selection of variables, sum of emission by year and fips
dfplot2 <- NEI %>% 
    subset(fips=="24510" | fips=="06037")%>% 
    subset(type=="ON-ROAD") %>% 
    select(Emissions,year, fips) %>% 
    group_by(year, fips) %>% 
    summarize_all(sum) %>% 
    ungroup() %>% 
    spread(.,fips,Emissions)

colnames(dfplot2) <- c( "year", "Los Angeles", "Baltimore") #naming the variables

#Scaling the variables to compare the variation (%) from the two County
dfplot2 <- dfplot2 %>% 
    mutate(Baltimore=scale(Baltimore),
           `Los Angeles`=scale(`Los Angeles`))


png(filename = "./Plot6.png", width = 480, height = 480, units = "px")

par(mfrow = c(1,2))

plot(dfplot[,1:2],
     type = "b",
     pch = 20,
     col = "blue",
     xlab = "year",
     ylab = "Total Emissions in tons",
     ylim = rng)
lines(dfplot[,c(1,3)], 
      type = "b",
      pch = 20,
      col = "darkgreen")

plot(dfplot2[,1:2],
     type = "b",
     pch = 20,
     col = "blue",
     xlab = "year",
     ylab = "Total Emissions scaled value",
     ylim = c(-1.1,2))
lines(dfplot2[,c(1,3)], 
      type = "b",
      pch = 20,
      col = "darkgreen")

legend("topright",
       lty=1,lwd=1,
       col=c("blue","darkgreen"),
       legend = c("Los Angeles", "Baltimore"))

mtext("Motor Vehicle Emissions in Baltimore City and Los Angeles County", outer=TRUE,  cex=1.2, line=-2.5)

dev.off()

