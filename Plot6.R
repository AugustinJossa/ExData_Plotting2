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

#Plot 6

NEI_Vehicles_ok$year<- as.factor(NEI_Vehicles_ok$year)
motor<- grepl("vehicle", SCC$SCC.Level.Two, ignore.case = TRUE)
SCC_motor<- SCC[motor, 1]
NEI_vehicles<- NEI[NEI$SCC %in% SCC_motor, ]
NEI_vehicles_Baltimore<- NEI_vehicles[NEI_vehicles$fips=="24510", ]
NEI_vehicles_Baltimore$fips<- "Baltimore"
NEI_vehicles_California<- NEI_vehicles[NEI_vehicles$fips=="06037", ]
NEI_vehicles_California$fips<- "Los Angeles City"

NEI_Vehicles_ok<- rbind(NEI_vehicles_Baltimore, NEI_vehicles_California)

g4<- ggplot(NEI_Vehicles_ok, aes(year, Emissions, fill=year)) +
        geom_bar(stat = "identity") +
        facet_grid(. ~ fips) + 
        labs(x="Years", y="PM2.5 Emissions (Tons)") +
        labs(title="Motor vehicle PM2.5 emissions in Baltimore City and LA") + 
        theme_bw()
print(g4)
dev.copy(png, file = "Plot6.png", width=480, height=480, units="px")
dev.off()