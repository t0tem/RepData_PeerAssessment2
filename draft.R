download.file("https://d396qusza40orc.cloudfront.net/repdata%2Fdata%2FStormData.csv.bz2", "StormData.csv.bz2")


x <- read.csv("StormData.csv.bz2")

names(StormData)

qplot(1:length(StormData[,1]), StormData$CROPDMG)
library(ggplot2)
length(StormData[,1])

unique(StormData$CROPDMGEXP)

x <- StormData[StormData$PROPDMGEXP %in% c("-", "?", "+", "0", "1", "2", "3", "4", "5", "6", "7", "8"),]

var_names <- c("EVTYPE", "FATALITIES", "INJURIES", "PROPDMG", "PROPDMGEXP", "CROPDMG", "CROPDMGEXP")

storm_tidy <- StormData[var_names]
library(dplyr)
storm_tidy <- storm_tidy %>%
      group_by(EVTYPE) %>% 
      summarise(FATALITIES = sum(FATALITIES, na.rm = TRUE),
                INJURIES = sum(INJURIES, na.rm = TRUE)) %>% 
      as.data.frame()
par(mfrow=c(1,2))
pie(storm_tidy$FATALITIES)
pie(storm_tidy$INJURIES)
storm_tidy[834,]

StormData[storm_tidy$PROPDMGEXP == "5", ]$REMARKS

x <- storm_tidy[!(storm_tidy$PROPDMGEXP %in% c("K", "k", "M", "m", "B", "b")), ]

storm_tidy[!(storm_tidy$PROPDMGEXP %in% c("K", "k", "M", "m", "B", "b")), ]$PROPDMGEXP <- 0

head(x)
summary(storm_tidy$PROPDMGEXP)


head(storm_tidy[storm_tidy$PROPDMGEXP != '0',])

x <- storm_tidy

x

x$PROPDMGEXP <- as.character(x$PROPDMGEXP)
head(x)

x[storm_tidy$PROPDMGEXP %in% c("K", "k"), ]$PROPDMGEXP <- 1000

table(x$PROPDMGEXP)


rm(list=ls()[-1])


ls()[-1]


par(mfrow = c(1,2))
with(fatal, pie(fatalities, labels = paste(EVTYPE[1:5], fatalities[1:5], sep = " - "),
                clockwise = TRUE))
with(injur, pie(injures, labels = paste(EVTYPE[1:5], injures[1:5], sep = " - "),
                clockwise = TRUE))














