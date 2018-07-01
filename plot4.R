#setwd("C:/Users/ram.p/Documents/R/CDSS4.2")
#-------Read Data-------#
data0=readRDS("summarySCC_PM25.rds")
source0=readRDS("Source_Classification_Code.rds")

#-------Duplicate the Dataset-------#
data1=data0

#-------making all col names lower case-------#
names(data1)=tolower(names(data1))

#-------subsetting only Coal Combustion SOurce-------#
comb=grepl("comb",as.character(source0$Short.Name),ignore.case = T)
coal=grepl("coal",as.character(source0$Short.Name),ignore.case = T)
source1=source0[comb & coal,]
scc=unique(source1$SCC)
data1=data1[data1$scc %in% scc,]

#-------Calculating Year wise median emission-------#
med=with(data1,tapply(emissions,year,sum,na.rm=T))

#-------Plot and Save as PNG-------#
png(filename="plot4.png")
par(mfrow=c(1,1),mar=c(4,4,2,2))
barplot(med)
title(main="Year wise Emission for Coal Combustion (Total)", ylab="Emission (Total)")
dev.off()


  

