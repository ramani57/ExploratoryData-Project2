
NEI <- readRDS("C:/Users/538321/Documents/DataManagement/ExploratoryDataAnalysis/exdata_data_NEI_data/summarySCC_PM25.rds")
library(dplyr)
subdata <- filter(NEI,(year == 1999 | year == 2002 | year == 2005 | year == 2008| fips == "24510") )
dataforplot1 <- select(subdata,Emissions, year)
aggregatevalue <- aggregate(dataforplot1$Emissions, list(year = dataforplot1$year), sum)
colnames(aggregatevalue)[2] = "Emissions"
png("C:/Users/538321/Documents/DataManagement/ExploratoryDataAnalysis/exdata_data_NEI_data/plot2.png",width=480,height=480,units="px",bg="transparent")
barplot(
  (aggregatevalue$Emissions)/10^6, 
  names.arg=aggregatevalue$year, xlab = "Year", ylab = "PM2.5 Emissions (10^6 Tons)", main="Total PM2.5 Emissions From all Baltimore City Sources")

dev.off()