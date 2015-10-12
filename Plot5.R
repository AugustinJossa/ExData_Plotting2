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


#Plot 5

NEI_BaltimoreCity_motor$year<- as.factor(NEI_BaltimoreCity_motor$year)
motor<- grepl("vehicle", SCC$SCC.Level.Two, ignore.case = TRUE)
SCC_motor<- SCC[motor, 1]
NEI_BaltimoreCity_motor<- NEI_BaltimoreCity[NEI_BaltimoreCity$SCC %in% SCC_motor, ]

g3<- ggplot(NEI_BaltimoreCity_motor, aes(year, Emissions, fill=year)) +
        geom_bar(stat="identity") + 
        labs(x="Years", y="PM2.5 Emisions (Tons)") +
        labs(title="PM2.5 Emissions from motor vehicle in the Baltimore City", cex.main= 0.7) +
        theme_bw()
print(g3)
dev.copy(png, file = "Plot5.png", width=480, height=480, units="px")
dev.off()
