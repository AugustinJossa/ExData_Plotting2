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


#Plot 2

NEI_BaltimoreCity<- NEI[NEI$fips=="24510", ]
agg_BaltimoreCity<- aggregate(Emissions ~ year, NEI_BaltimoreCity, sum)
barplot((agg_BaltimoreCity$Emissions), names.arg=agg_BaltimoreCity$year, xlab = "Year", ylab = "PM2.5 (Tons)", main="PM2.5 Emissions in the Baltimore City", cex.main=1)
NEI$year<- as.integer(NEI$year)
dev.copy(png, file = "Plot2.png", width=480, height=480, units="px")
dev.off()

