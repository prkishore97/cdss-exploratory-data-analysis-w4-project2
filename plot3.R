#setwd("C:/Users/ram.p/Documents/R/CDSS4.2")
library(ggplot2)
#-------Read Data-------#
data0=readRDS("summarySCC_PM25.rds")
source0=readRDS("Source_Classification_Code.rds")

#-------Duplicate the Dataset-------#
data1=data0

#-------making all col names lower case-------#
names(data1)=tolower(names(data1))

#-------subsetting only Baltimore city-------#
data2=data1[data1$fips=="24510",]
data2$year=as.Date(as.character(data2$year),"%Y")

#-------Bar plot using ggplot2-------#
p=ggplot(data=data2,aes(year,emissions))+geom_col()
p=p+facet_grid(.~type)
p=p+xlab("Year")+ylab("emission")+ggtitle("YOY-Type wise emission data for Baltimore")
ggsave("plot3.png")
