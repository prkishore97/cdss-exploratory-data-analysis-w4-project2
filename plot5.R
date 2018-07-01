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


#-------subsetting only Motor Vehicle source-------#
veh=grepl("vehicles",source0$Short.Name,ignore.case = T)
source1=source0[veh,]
veh_data=unique(source1$SCC)
data3=data2[data2$scc %in% veh_data,]

#-------Calculating Year wise median emission-------#
med=with(data3,tapply(emissions,year,sum,na.rm=T))

#-------Plot and Save as PNG-------#
png(filename="plot5.png")
par(mfrow=c(1,1),mar=c(4,4,2,2))
barplot(med)
title(main="Year wise Emission for Vehicle SOurce (Total)", ylab="Emission (Total)")
dev.off()

