#setwd("C:/Users/ram.p/Documents/R/CDSS4.2")
#-------Read Data-------#
data0=readRDS("summarySCC_PM25.rds")
source0=readRDS("Source_Classification_Code.rds")

#-------Duplicate the Dataset-------#
data1=data0

#-------making all col names lower case-------#
names(data1)=tolower(names(data1))

#-------subsetting only Baltimore city-------#
data2=data1[data1$fips=="24510",]

#-------Calculating Year wise median emission-------#
med=with(data2,tapply(emissions,year,sum,na.rm=T))


#-------Plot and Save as PNG-------#
png(filename="plot2.png")
par(mfrow=c(1,1),mar=c(4,8,8,8))
barplot(med)
title(main="Year wise Emission for Baltimore City (Total)", ylab="Emission (Total)")
dev.off()