#Change working directory
setwd("~/Desktop/MOOC/Programming_assignment/Explore/P2")

file.url<-"https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
if(!file.exists("./exdata-data-NEI_data.zip"))
{download.file(file.url, destfile = "./exdata-data-NEI_data.zip", method="curl")}
unzip("exdata-data-NEI_data.zip", overwrite = TRUE)

library(data.table)
library(datasets)
library(ggplot2)

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")


#Plot 1

agg<- aggregate(Emissions ~ year, NEI, sum)
barplot((agg$Emissions)/10^6, names.arg=agg$year, xlab = "Year", ylab = "PM2.5 (10^6 Tons)", main="Total PM2.5 Emissions for all sources")
dev.copy(png, file = "Plot1.png", width=480, height=480, units="px")
dev.off()
