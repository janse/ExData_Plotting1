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
  filename = "plot4.png",
  width = 480,
  height = 480,
  units = "px"
)

# Create frame for 4 graphs
par(mfrow = c(2, 2))

# Add top-left graph
with(
  data,
  plot(
    Date.Time,
    Global_active_power,
    type = "n",
    xlab = "",
    ylab = "Global Active Power"
  )
)
with(data, lines(Date.Time, Global_active_power))

# Add top-right graph
with(data, plot(Date.Time, Voltage, type = "n", xlab = "datetime"))
with(data, lines(Date.Time, Voltage))

# Add bottom-left graph
with(data,
     plot(
       Date.Time,
       Sub_metering_1,
       type = "n",
       xlab = "",
       ylab = "Energy sub metering"
     ))
with(data, lines(Date.Time, Sub_metering_1, col = "black"))
with(data, lines(Date.Time, Sub_metering_2, col = "red"))
with(data, lines(Date.Time, Sub_metering_3, col = "blue"))
legend(
  "topright",
  lty = 1,
  col = c("black", "blue", "red"),
  legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3")
)

# Add bottom-right graph
with(data,
     plot(
       Date.Time,
       Global_reactive_power,
       type = "n",
       xlab = "datetime"
     ))
with(data, lines(Date.Time, Global_reactive_power))
dev.off()