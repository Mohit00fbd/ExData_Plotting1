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

df$date_time <- ymd_hms(paste(df$date, df$time, sep = " "))

png(file="plot3.png", width = 480, height = 480, units = "px")

with(df, 
     {plot(date_time, sub_metering_1,
          type="n", xlab = "",
          ylab = "Energy sub metering")
      lines(date_time, sub_metering_1)
      lines(date_time, sub_metering_2, col="red")
      lines(date_time, sub_metering_3, col="blue")
      legend("topright", col= c("black", "red", "blue"), lty=1,
             legend = c("Sub_metering_1","Sub_metering_2", "Sub_metering_3"))
     }
)

dev.off()