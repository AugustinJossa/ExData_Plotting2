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

#Plot 3

NEI_BaltimoreCity$year<- as.factor(NEI_BaltimoreCity$year)
g<- ggplot(NEI_BaltimoreCity, aes(year, Emissions)) + 
        geom_bar(stat="identity") + 
        facet_grid(. ~ type) +
        labs(x="Years", y="PM2.5 Emisions (Tons)") +
        labs(title="PM2.5 Emissions in the Baltimore City by type") +
        theme_bw()
print(g)
dev.copy(png, file = "Plot3.png", width=480, height=480, units="px")
dev.off()

