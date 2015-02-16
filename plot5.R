library(dplyr)
library(ggplot2)
NEI <- readRDS("C:/Users/538321/Documents/DataManagement/ExploratoryDataAnalysis/exdata_data_NEI_data/summarySCC_PM25.rds")
SRC <- readRDS("C:/Users/538321/Documents/DataManagement/ExploratoryDataAnalysis/exdata_data_NEI_data/Source_Classification_Code.rds")
CC <- grep("vehicle",SRC$ EI.Sector, value=T,ignore.case=T)

#CC1 <- SRC[grep("vehicle", rownames(SRC)),]
head(CC)
motorvehicles <-  filter(SRC, SRC$EI.Sector== "Mobile - On-Road Gasoline Light Duty Vehicles")
subsetSCC_mv <- subset(SRC, SRC$EI.Sector== "Mobile - On-Road Gasoline Light Duty Vehicles", select = SCC)
subdata_year_county <- filter(NEI,(year == 1999 | year == 2002 | year == 2005 | year == 2008| fips == "24510") )
subsetSCC_NEC <- subset(NEI,  subsetSCC_mv$SCC %in% subdata_year_county$SCC )
head(subsetSCC_NEC)
subdata <-subset(subsetSCC_NEC, select = c(Emissions, year))
head(subdata)
aggregatevalue <- aggregate(subdata$Emissions, list(year = subdata$year), sum)
head( aggregatevalue)
colnames(aggregatevalue)[2] = "Emissions"
png("C:/Users/538321/Documents/DataManagement/ExploratoryDataAnalysis/exdata_data_NEI_data/plot5.png",width=480,height=480,units="px",bg="transparent")
plot( aggregatevalue$year,aggregatevalue$Emissions, main="Emisions By Motor Vegilce", horiz=TRUE,
    xlab = "Year", ylab = "PM2.5 Emissions (10^6 Tons)")
dev.off()

