#setwd("C:/Users/ram.p/Documents/R/CDSS4.2")
library(ggplot2)
#-------Read Data-------#
data0=readRDS("summarySCC_PM25.rds")
source0=readRDS("Source_Classification_Code.rds")

#-------Duplicate the Dataset-------#
data1=data0

#-------making all col names lower case-------#
names(data1)=tolower(names(data1))

#-------subsetting only Motor Vehicle source-------#
veh=grepl("vehicles",source0$Short.Name,ignore.case = T)
source1=source0[veh,]
veh_data=unique(source1$SCC)
data2=data1[data1$scc %in% veh_data,]

#-------subsetting only Baltimore city-------#
data3=data2[data2$fips=="24510",]
data3$city="Baltimore City"

#-------subsetting only California-------#
data4=data2[data2$fips=="06037",]
data4$city="California"

#-------Combine tow datasets-------#
f_data <- rbind(data3,data4)

#-------Plot and Save as PNG-------#
ggp <- ggplot(f_data, aes(x=factor(year), y=emissions, fill=city)) +
  geom_bar(aes(fill=year),stat="identity") +
  facet_grid(scales="free", space="free", .~city) +
  guides(fill=FALSE) + theme_bw() +
  labs(x="year", y=expression("Total PM"[2.5]*" Emission")) + 
  labs(title=expression("PM"[2.5]*" Motor Vehicle Source Emissions in Baltimore & LA, 1999-2008"))
ggsave("plot6.png")




