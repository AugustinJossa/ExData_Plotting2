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

#Plot 4

NEI_Combustion_coal$year<- as.factor(NEI_Combustion_coal$year)
combustion<- grepl("combustion", SCC$SCC.Level.One, ignore.case = TRUE) 
coal<- grepl("coal", SCC$SCC.Level.Four, ignore.case = TRUE)
combustion_coal<- combustion & coal
SCC_combustion_coal<- SCC[combustion_coal, 1]
NEI_Combustion_coal<- NEI[NEI$SCC %in% SCC_combustion_coal, ]

g2<- ggplot(NEI_Combustion_coal, aes(year, Emissions/10^5)) + 
        geom_bar(stat="identity") + 
        labs(x="Years", y="PM2.5 Emisions (10^5 Tons)") +
        labs(title="PM2.5 Emissions in the Baltimore City by type") +
        theme_bw()
print(g2)
dev.copy(png, file = "Plot4.png", width=480, height=480, units="px")
dev.off()

