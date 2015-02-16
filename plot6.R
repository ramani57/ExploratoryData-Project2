library(dplyr)
library(ggplot2)
library(sqldf)
NEI <- readRDS("C:/Users/538321/Documents/DataManagement/ExploratoryDataAnalysis/exdata_data_NEI_data/summarySCC_PM25.rds")
SRC <- readRDS("C:/Users/538321/Documents/DataManagement/ExploratoryDataAnalysis/exdata_data_NEI_data/Source_Classification_Code.rds")
##colnames(SRC)
##colSums(is.na(SRC))
Vehicle_SCC <- subset(SRC, grepl("vehicle", SCC.Level.Three ,ignore.case=T))
##sapply(NEI,typeof)
#head(SRC_Motor,5)
##Baltimore County
subdata_year_LA_Baltimorecounty <- filter(NEI,(year == 1999 | year == 2002 | year == 2005 | year == 2008 ))
filterBaltimore <- filter(subdata_year_LA_Baltimorecounty, (fips == "24510"))
subsetSCC_NECBaltimore <- subset(NEI,  Vehicle_SCC$SCC %in% filterBaltimore$SCC )
aggregateBaltimore <- aggregate(subsetSCC_NECBaltimore$Emissions, list(year = subsetSCC_NECBaltimore$year), sum)
##head(aggregateBaltimore)
aggregateBaltimore$group <- rep("Baltimore County", length(aggregateBaltimore[, 1]))
colnames(aggregateBaltimore)[2] = "Emissions"
filterLAcounty <- filter(subdata_year_LA_Baltimorecounty,(fips == "06037") )
subsetSCC_NECLACounty <- subset(NEI,  Vehicle_SCC$SCC %in% filterLAcounty$SCC )
aggregateLACounty <- aggregate(subsetSCC_NECLACounty$Emissions, list(year = subsetSCC_NECLACounty$year), sum)
aggregateLACounty$group <- rep("LA County", length(aggregateLACounty[, 1]))
##filterLAcounty$group <- rep("LA County", length(filterLAcounty[, 1]))
##head(aggregateLACounty)
colnames(aggregateLACounty)[2] <- "Emissions"
mergedcountydata <- rbind(aggregateBaltimore,aggregateLACounty)
head(mergedcountydata)
colnames(mergedcountydata) <- c("Year", "Emissions", "Group")
png("C:/Users/538321/Documents/DataManagement/ExploratoryDataAnalysis/exdata_data_NEI_data/plot6.png",width=480,height=480,units="px",bg="transparent")
qplot(Year, Emissions, data = mergedcountydata, group = Group, color = Group, 
      geom = c("point", "line"), ylab = expression("Total Emissions, PM"[2.5]), 
      xlab = "Year", main = "Comparison of Total Emissions by County")

dev.off()


