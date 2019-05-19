# Weather Case Study

#Include the libraries
library(readxl)
library(stringr)
library(tidyr)
library(dplyr)

setwd("E:\\Jay_3rd_July_2018\\R_Sessions\\12thAug")
getwd()
weather <- read_excel("weather.xlsx")
str(weather)

class(weather)
length(colnames(weather))
View(weather)

#Remove unwanted columns
weather1 <- weather[, -1] #OR
weather1 <- weather[2:35]
colnames(weather1)

#Make data day wise
weather1 <- gather(weather1, Day, Values, X1:X31)
View(weather1)

weather2 <- spread(weather1, measure, Values)
View(weather2)

weather2$Day <- str_replace(weather2$Day, "X", "")
weather3 <- unite(weather2, "Date", year, month, Day, sep = "-")
View(weather3)
str(weather3)

weather3$Date <- as.Date(weather3$Date)  
#Mark Row#86 & 87 for NAs because Date formatis wrong

weather3$Date[weather3$Date[is.na(weather3$Date)]]

weather4 <- filter(weather3, !is.na(weather3$Date))
View(weather4)

weather3$Date[is.na(weather3$Date)]

weather4$Events[is.na(weather4$Events)] <- "No Events"
str(weather4)

weather4$Date[is.na(weather4$Date)]

weather4$PrecipitationIn[weather4$PrecipitationIn == "T"] <- 0
weather4[c(2,4:23)] <- lapply(weather4[c(2,4:23)], as.numeric)

str(weather4)
#-------------------
