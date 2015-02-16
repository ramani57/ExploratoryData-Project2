
NEI <- readRDS("C:/Users/538321/Documents/DataManagement/ExploratoryDataAnalysis/exdata_data_NEI_data/summarySCC_PM25.rds")
SCC <- readRDS("C:/Users/538321/Documents/DataManagement/ExploratoryDataAnalysis/exdata_data_NEI_data/Source_Classification_Code.rds")
head(NEI,15)
library(dplyr)
subdata <- filter(NEI,(year == 1999 | year == 2002 | year == 2005 | year == 2008 ))
dataforplot1 <- select(subdata,Emissions, year)
aggregatevalue <- aggregate(dataforplot1$Emissions, list(year = dataforplot1$year), sum)
colnames(aggregatevalue)[2] = "Emissions"
head(aggregatevalue, 5)
png("C:/Users/538321/Documents/DataManagement/ExploratoryDataAnalysis/exdata_data_NEI_data/plot1.png",width=480,height=480,units="px",bg="transparent")
barplot(aggregatevalue$Emissions/10^6, main="Total PM2.5 Emissions Across US", horiz=TRUE,
        names.arg=aggregatevalue$year, xlab = "Year", ylab = "PM2.5 Emissions (10^6 Tons)")
dev.off()