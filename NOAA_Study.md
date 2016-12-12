# Studying the most harmful weather events in the US in the period from 1950 to 2011

# Synopsis

In this analysis we aim to explore the U.S. National Oceanic and Atmospheric Administration's (NOAA) storm database which tracks characteristics of major storms and weather events in the United States. Data includes when and where the events occur, as well as estimates of any fatalities, injuries, and property damage.
The addressed questions were:  
Across the United States, which types of events are most harmful with respect to population health?  
Across the United States, which types of events have the greatest economic consequences?  

# Data Processing 

## Downloading the data
First we download the data from [this source](https://d396qusza40orc.cloudfront.net/repdata%2Fdata%2FStormData.csv.bz2) and store it in our R working directory (we skip the step if file is already there)

```r
if(!file.exists("StormData.csv.bz2")) {
      link <- "https://d396qusza40orc.cloudfront.net/repdata%2Fdata%2FStormData.csv.bz2"
      download.file(link, "StormData.csv.bz2")
}
```

## Reading in the data

We directly read in the global dataset stored in comma separated file inside bz2 archive

```r
StormData <- read.csv("StormData.csv.bz2")
```

########dim??


## Transforming data

For the purpose of our analysis we only keep following columns in dataset  
EVTYPE - the type of weather event occured  
FATALITIES - number of fatalities caused by weather event  
INJURIES - number of injuries caused by weather event  
PROPDMG - a numeric vector representing property damage in USD  
PROPDMGEXP -  magnitude of the PROPDMG number, (i.e. “K” for thousands, “M” for millions, and “B” for billions)   
CROPDMG - a numeric vector representing crop damage in USD
CROPDMGEXP - magnitude of the CROPDMG number, (i.e. “K” for thousands, “M” for millions, and “B” for billions)

Thus, we subset the global dataset for the listed variables

```r
var_names <- c("EVTYPE", "FATALITIES", "INJURIES", "PROPDMG", "PROPDMGEXP", "CROPDMG", "CROPDMGEXP")

storm_tidy <- StormData[var_names]
```


## Cleaning data

Next step is normalize the damage values with respect to corresponding magnitude.  
First we take a look at magnitude variables:  


```r
summary(storm_tidy$PROPDMGEXP)
```

```
##             -      ?      +      0      1      2      3      4      5 
## 465934      1      8      5    216     25     13      4      4     28 
##      6      7      8      B      h      H      K      m      M 
##      4      5      1     40      1      6 424665      7  11330
```

```r
summary(storm_tidy$CROPDMGEXP)
```

```
##             ?      0      2      B      k      K      m      M 
## 618413      7     19      1      9     21 281832      1   1994
```

As we can see there are bunch of observations with not acceptable values in magnitude.  
So we change to zero all of them.

```r
storm_tidy[!(storm_tidy$PROPDMGEXP %in% c("K", "k", "M", "m", "B", "b")), ]$PROPDMGEXP <- 0
storm_tidy[!(storm_tidy$CROPDMGEXP %in% c("K", "k", "M", "m", "B", "b")), ]$CROPDMGEXP <- 0
```

We check again the summary and see that now only the acceptable values are there

```r
summary(storm_tidy$PROPDMGEXP)
```

```
##             -      ?      +      0      1      2      3      4      5 
##      0      0      0      0 466255      0      0      0      0      0 
##      6      7      8      B      h      H      K      m      M 
##      0      0      0     40      0      0 424665      7  11330
```

```r
summary(storm_tidy$CROPDMGEXP)
```

```
##             ?      0      2      B      k      K      m      M 
##      0      0 618440      0      9     21 281832      1   1994
```




