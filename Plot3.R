NEI <- readRDS("C:/Users/538321/Documents/DataManagement/ExploratoryDataAnalysis/exdata_data_NEI_data/summarySCC_PM25.rds")
library(dplyr)
library(ggplot2)
subdata <- filter(NEI,(year == 1999 | year == 2002 | year == 2005 | year == 2008| fips == "24510") )
dataforplot1 <- select(subdata,Emissions, year,type)
aggregatevalue <- aggregate(dataforplot1$Emissions, list(year = dataforplot1$year, type = dataforplot1$type ), sum)
colnames(aggregatevalue)[3] = "Emissions"
png("C:/Users/538321/Documents/DataManagement/ExploratoryDataAnalysis/exdata_data_NEI_data/plot3.png",width=480,height=480,units="px",bg="transparent")
egraph <-  ggplot(aggregatevalue,aes(x= year, y= Emissions, col= type)) +geom_point(alpha= .3)+
  geom_smooth(apha= .3, size = 1, method= "loess")+
  ggtitle("Total Emissions by Type in Baltimore City")
print(egraph)
dev.off()
