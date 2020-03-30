x= "EduPristine"
y = "Business"
z = "Analytics"
res = paste(x,y,z)
res
res2 = paste0(x,y,z)
res2
res3 <- paste(x,y,z, sep = '')
res4 <- paste(x,y,z, sep='-')
res3
res4
res5 <- sub('-',',',res4)
res5
res6 <- gsub('-',',',res4)
res6
res7 <- substr(res6, 1, 11)
res7
x = 10
y=20
z=30
x>y
z>y
x==z
z>y & y>x
x>y | z>y
x <- c(2,3,5,1,2,4,-5)
x
class(x)
is.vector(x)
x[3]
x[1:4]
x[c(1:3,5,7)]
x[-2]
x[-c(1:3,5,7)]
x>3
x[x>3]
x <- seq(1,5,by=1)
x
y <- seq(1,5,length=11)
y
#Vector operations are similar to normal matrix operations
x <- letters #Creating alphabets
y <- 1:26 # A sequence from 1 to 26
z <- paste(x,y, sep='*') #Creating a vector pasting x and y with an asterisk in between
res <- paste(z, collapse =' + ' ) #Combining all elements of the vector using a plus sign in between
x
y
z
res
#---
#Matching two Vectors: Match
x=c('a','$','e','1','i','o','u')
y=letters
match(x,y)
#Matching two vectors: %in% - Matching logically
x %in% y

#Modulo Operator: %% -  Finding out remainder
5%%3

#Extract odd numbers from the vector 2:99 
x=2:99
which(x%%2!=0)

#The returned vector contains indices not the values themselves, you can get the values by passing these indices to vector for sub-setting.
x[which(x%%2!=0)]

#Random Sample
x=1:50
sample(x,5) #Choosing 5 random numbers

#Fixing seed for randomizing algorithm
set.seed(10)
sample(x,5)
x = 1:5
sample(x,10, replace = TRUE) # repeatition allowed

#Vectors are called atomic data type because they can not contain higher data types themselves.
#List are recursive data types and can contain all sorts of object and they do not need to be of same type either:
x=1:10
y=letters
z=3.14
list1=list(x,y,z)
list1

#Accessing individual list elements
list1[[2]]
#Accessing the 10th element of list 2
list1[[2]][10]

#Naming list elements
list2=list(cust_num=x,prod_name=y,marktng_expense=z)
list2

#Accessing the 10th element of list 2
list2$prod_name[10]

#Data frames: A special kind of list which has vectors of equal length
set.seed(15)
x=1:26
y=letters
df=data.frame(x,y)
df
View(df) #View the data set
names(df) #outputs variable names of the data set
names(df)=c('Prod_ID','Prod_Name') #changing names
df

rownames(df) #Provide row names
rownames(df)=paste0('R',1:26) #Renaming rownames
df

dim(df) #Gives dimensions
nrow(df) #Row numbers
ncol(df) #Column numbers
str(df) #Quick glimpse of the structure of data

df$Prod_Name <- as.character(df$Prod_Name) #Forcing the type on a particular column
str(df)

setwd("D:/Personal/Learning/R/Practice R")
filedata1 <- read.csv('CCData1.csv', stringsAsFactors = F) #Reading the data file
str(filedata1) #Getting glimpse of the data
filedata3 <- read.csv('CCData1.csv') #Reading the data file
str(filedata3) #Getting glimpse of the data
filedata2 <- read.csv('CCData1.csv', stringsAsFactors = F) #Reading dataset - creating another
str(filedata2) #Glimpse of the data


X<-matrix(rnorm(30), nrow=5, ncol=6)
X
apply(X,2 ,sum) # 2 for the column sum and 1 for row


A<-matrix(1:9, 3,3)
B<-matrix(4:15, 4,3)
C<-matrix(8:10, 3,2)
MyList<-list(A,B,C) # display the list
MyList
# extract the second column from the list of matrices, using the selection operator '['
lapply(MyList,'[', , 2) # every element of the list, obtail as a list
sapply(MyList,'[', 2,1 ) # 1 is for the row and 2nd element


#Data manipulation
install.packages("dplyr")
library(dplyr)

#sleep data
msleep = read.csv("mammals.csv")
#Selecting columns using select()
#There are multiple ways to use select in dplyr. Here are few examples using the sleep data:
sleepData <- select(msleep, name, sleep_total)
sleepData
#To select all the columns except a specific column, use the '-' (subtraction) operator (also known as negative indexing)
head(select(msleep, -name))
#To select a range of columns by name, use the ':' (colon) operator
head(select(msleep, name:order))
#To select all columns that start with the character string 'sl', use the function starts_with()
head(select(msleep, starts_with("sl")))


#Let us filter out only the required rows based on multiple conditions

#Filter the rows for mammals that sleep a total of more than 16 hours.
filter(msleep, sleep_total >= 16)
#Filter the rows for mammals that sleep a total of more than 16 hours and have a body weight of greater than 1 kilogram.
filter(msleep, sleep_total >= 16, bodywt >= 1)
#Filter the rows for mammals in the Perissodactyla and Primates taxonomic order
filter(msleep, order %in% c("Perissodactyla", "Primates"))

#Let's introduce the pipe operator: %>%. dplyr imports this operator from another package (magrittr). This operator allows you to pipe the output from one function to the input of another function. Instead of nesting functions (reading from the inside to the outside), the idea of piping is to read the functions from left to right.

#Here's an example you have seen:
head(select(msleep, name, sleep_total))

#Now in this case, we will pipe the msleep data frame to the function that will select two columns (name and sleep_total) and then pipe the new data frame to the function�head(),�which will return the head of the new data frame. 

msleep %>% select(name, sleep_total) %>% head

#Let us take another example where we want to arrange the data based on the 'order' variable:
msleep %>% arrange(order) %>% head

CCData<- as.data.frame(bind_rows(filedata1, filedata2)) #Merging
str(CCData) #Glimpse of the new data set

#Looking at the categorical variables in detail.
table(CCData$demographic_slice)

View(filter(CCData, country_reg %in% c("E", "W")))

select(CCData, customer_id, demographic_slice, est_income)

#Nesting
CCData %>%
  select(customer_id, country_reg, est_income) %>%
  filter(est_income > mean(est_income))

CCData %>%
  select(RiskScore, imp_cscore) %>%
  mutate(ScoreRatio = RiskScore/imp_cscore)

#Need to take a sample: Taking 70% data as sample
set.seed(11)
s=sample(1:nrow(CCData),0.7*nrow(CCData))
s

sampled.data <- CCData[s,]
glimpse(sampled.data)

