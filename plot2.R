## This R script will create a plot based on the Electric Power Consumption data found here:
## https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip

## The script assumes you have already downloaded and extracted the txt file into your
## working directory, and that the file inside the zip archive has not been renamed.

# Load necessary packages
library(data.table)
library(lubridate)
library(dplyr)

# Read and subset data
filename <- "household_power_consumption.txt"
data <- fread(filename, na.strings = "?")
data <- subset(data, Date == "1/2/2007" | Date == "2/2/2007")

# Combine date and time
data$Date <- dmy(data$Date)
data$Time <- hms(data$Time)
data <- mutate(data, Date.Time = Date)
data$Date.Time <- data$Date + data$Time

# Create plot as external png file
png(
  filename = "plot2.png",
  width = 480,
  height = 480,
  units = "px"
)
with(
  data,
  plot(
    Date.Time,
    Global_active_power,
    type = "n",
    xlab = "",
    ylab = "Global Active Power (kilowatts)"
  )
)
with(data, lines(Date.Time, Global_active_power))
dev.off()