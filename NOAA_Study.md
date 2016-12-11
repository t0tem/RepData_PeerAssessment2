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
