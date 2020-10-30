# Download and unzip the data
if (!file.exists('household_power_consumption.zip')) {
  download.file('https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip', 'household_power_consumption.zip')
}
if (!file.exists('household_power_consumption.txt')) {
  unzip('household_power_consumption.zip')
}

#Read data
data_raw <- read.table("household_power_consumption.txt", header=TRUE, na.strings="?", sep=";")
data <- data_raw[(data_raw$Date=="1/2/2007" | data_raw$Date=="2/2/2007" ), ]

#Format date and time
data$Date <- as.Date(data$Date, format="%d/%m/%Y")
dateTime <- paste(data$Date, data$Time)
data$DateTime <- as.POSIXct(dateTime)

#plot3
with(data, {
  plot(Sub_metering_1~DateTime, type="l",
       ylab="Energy sub metering", xlab="", cex=0.8)
  lines(Sub_metering_2~DateTime, col='Red')
  lines(Sub_metering_3~DateTime, col='Blue')
})
legend("topright", col=c("black", "red", "blue"), lty=1, lwd=1, 
       legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), cex=0.8)
dev.copy(png, file="plot3.png", height=480, width=480)
dev.off()
