## Load libraries
library(readr)
library(dplyr)
library(lubridate)

## Create data directory if it doesn't exist
if(!dir.exists("data")){
  dir.create("data")
}

## Download and read data file
if(!file.exists("./data/household_power_consumption.zip")){
  file_url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
  download.file(file_url, destfile = "./data/household_power_consumption.zip")
  if(!file.exists("./data/household_power_consumption.txt"))
    unzip("./data/household_power_consumption.zip", exdir = "data")
}

df <- read_delim("./data/household_power_consumption.txt", 
                 delim = ";",
                 na = "?")
df$Date <- dmy(df$Date)
names(df) <- tolower(names(df))

df <- df %>% filter(date >= as.Date("2007-02-01") & date <= as.Date("2007-02-02"))

png(file="plot1.png", width = 480, height = 480, units = "px")

with(df, 
     hist(global_active_power, 
          main = "Global Active Power",
          col = "red",
          xlab = "Global Active Power (kilowatts)",
          
          )
     )
dev.off()
