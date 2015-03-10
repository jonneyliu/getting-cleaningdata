
###Getting and cleaning daat Quiz 1

dat<- read.csv("Getting & cleaning data/getdata-data-ss06hid.csv")
datfil<-dat[!is.na(dat$VAL),]
dim(datfil[datfil$VAL>23,])


#Q2 A: more than one variable per column

##Q3 - USE DPLYR package
library(xlsx)
mydf<-read.xlsx("Getting & cleaning data/getdata-data-DATA.gov_NGAP.xlsx",sheetIndex = 1, header = TRUE)
rowIndex = 18:23
colIndex = 7:15
mydf<-read.xlsx("Getting & cleaning data/getdata-data-DATA.gov_NGAP.xlsx",sheetIndex = 1, rowIndex = rowIndex, colIndex = colIndex)
sum(mydf$Zip*mydf$Ext,na.rm=T) 


##Q4 XML 
library(XML)
fileurl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Frestaurants.xml"
fileurl2 <- "Getting & cleaning data/getdata-data-restaurants.xml"
doc <- xmlTreeParse(fileurl2,useInternal = TRUE)
rootNode <- xmlRoot(doc)
xmlName(rootNode)
names(rootNode)
xmlSApply(rootNode,xmlValue)
xpathSApply(rootNode,"//name",xmlValue)
zipcodes <- xpathSApply(rootNode,"//zipcode",xmlValue)


###Q5 fread - data.table is much faster for large datasets
library(data.table)
file <- "Getting & cleaning data/getdata-data-ss06pid.csv"
DT<-fread(file)
system.time(tapply(DT$pwgtp15,DT$SEX,mean))
system.time(DT[,mean(pwgtp15),by=SEX])
system.time(mean(DT$pwgtp15,by=DT$SEX))
system.time(sapply(split(DT$pwgtp15,DT$SEX),mean))
system.time(rowMeans(DT)[DT$SEX==1])
system.time( rowMeans(DT)[DT$SEX==2])
system.time(mean(DT[DT$SEX==1,]$pwgtp15); mean(DT[DT$SEX==2,]$pwgtp15))
