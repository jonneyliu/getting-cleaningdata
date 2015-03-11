###Getting and Cleaning Data Week 3 lecture notes

##Subset & Sorting
set.seed(13435)
X <- data.frame("var1"=sample(1:5),"var2"=sample(6:10),"var3"=sample(11:15))
X <- X[sample(1:5),]; X$var2[c(1,3)] = NA
X
X[,1]
X[,"var1"]
X[1:2,"var2"]

#sorting
sort(X$var1)
sort(X$var1,decreasing=TRUE) #decresing
sort(X$var2,na.last=TRUE) #put NAs at the end
#ordering
X[order(X$var1,X$var3),]
#with pylr:
library(plyr)
arrange(X,var1)
arrange(X,desc(var1))

X$var4 <- rnorm(5) #add column
Y <- cbind(X,rnorm(5))


##summary
if(!file.exists("./data")){dir.create("./data")}
fileUrl <- "https://data.baltimorecity.gov/api/views/k5ry-ef3g/rows.csv?accessType=DOWNLOAD"
download.file(fileUrl,destfile="./data/restaurants.csv",method="curl")
restData <- read.csv("./data/restaurants.csv")
head(restData,n=3)
tail(restData,n=3)

summary(restData)
str(restData) 
quantile(restData$councilDistrict,na.rm=TRUE)
quantile(restData$councilDistrict,probs=c(0.5,0.75,0.9))

#make table
table(restData$zipCode,useNA="ifany")
table(restData$councilDistrict,restData$zipCode)

##check for missing values
sum(is.na(restData$councilDistrict))
any(is.na(restData$councilDistrict))

colSums(is.na(restData)) #check if there is a NA value in a col
all(colSums(is.na(restData))==0)  #shows that all column sums = 0 meaning no NA in dataset

table(restData$zipCode %in% c("21212"))
table(restData$zipCode %in% c("21212","21213")) ##%in% command useful when defining multiple value otherwise can just use ==

restData[restData$zipCode %in% c("21212","21213"),]  #return only the rows with 21212 or 21213 zipcodes
all(restData$zipCode > 0)


##data size
fakeData = rnorm(1e5)
object.size(fakeData)
print(object.size(fakeData),units="Mb")


###merging data

if(!file.exists("./data")){dir.create("./data")}
fileUrl <- "https://data.baltimorecity.gov/api/views/k5ry-ef3g/rows.csv?accessType=DOWNLOAD"
download.file(fileUrl,destfile="./data/restaurants.csv",method="curl")
restData <- read.csv("./data/restaurants.csv")

restData$nearMe = restData$neighborhood %in% c("Roland Park", "Homeland")
table(restData$nearMe)  #count how many properties are near you in c("Roland Park","Homeland")

restData$zipWrong = ifelse(restData$zipCode < 0, TRUE, FALSE)
table(restData$zipWrong,restData$zipCode < 0)
