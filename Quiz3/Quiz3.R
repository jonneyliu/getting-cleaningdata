### Quiz 3


##Question 1
library(dplyr)
dat<- read.csv("Getting & cleaning data/getdata-data-ss06hid.csv")
agricultureLogical <- dat$ACR >=3 & dat$AGS>=6
which(agricultureLogical) #return row numbers where above is true


##Question 2
#Reading jpeg files into R
library(jpeg)
pic<- readJPEG("Getting & cleaning data/getdata-jeff.jpg",native=TRUE)
quantile(pic, 0.3)
quantile(pic, 0.8)


library(plyr)


##Question 3
dtEd <- read.csv("Getting & cleaning data/getdata-data-EDSTATS_Country.csv")
head(dtEd)
names(dtEd)
dim(dtEd)
dtGDP <- read.csv("Getting & cleaning data/getdata-data-GDP.csv",skip=4,nrows=215) #skip the intro 4 lines in and remove region GDPs
dtGDP <- dtGDP[,c("X","X.1","X.3","X.4")] #choose columns with data in it
head(dtGDP)
names(dtGDP)
colnames(dtGDP) <- c("CountryCode","Rank","Long.Name","GDP") #rename the columns

dt <- merge(dtGDP, dtEd, all=TRUE, by=c("CountryCode")) ##merge the data together by country code
length(unique(dt$Rank))
sum(!is.na(unique(dt$Rank))) #this one will remove NAs

dt[order(dt$Rank, decreasing=TRUE),][13,]$Long.Name.x #order decreasing by GDP Rank, and return 13th in list Long.Name



###Question 4

#
sapply(split(dt$Rank, dt$Income.Group), mean,na.rm=TRUE) 



### Question 5

rankquantile <- quantile(dt$Rank, probs = c(0.0, 0.2, 0.4, 0.6, 0.8, 1.0),na.rm=TRUE)
dt$quantileGroup <- cut(dt$Rank,breaks = rankquantile)
table(dt$quantileGroup)
table(dt$quantileGroup, dt$Rank)
dt$quantileGroup
dtlmi <- dt[dt$Income.Group == "Lower middle income",]
table(dtlmi$quantileGroup)
library(Hmisc)
#using the Hmisc library cut2 function can be easier...
dt$quantileGroup <- cut2(dt$Rank,g = 4)
