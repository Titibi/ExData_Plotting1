#Checking if file already exists
if(!file.exists("exdata-data-household_power_consumption.zip")) {
  temp <- tempfile()
  download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",temp)
  unzip(temp)
}

#Loading file into R
hpc <- read.table("household_power_consumption.txt", header = TRUE, sep = ";" , col.names = c("Date","Time","Global_active_power","Global_reactive_power","Voltage","Global_intensity","Sub_metering_1","Sub_metering_2","Sub_metering_3"),na.strings = "?")
useful_dates<-grep("^1{1}/2/2007|^2{1}/2/2007",hpc$Date)
hpc <- hpc[useful_dates,]
hpc$Date <- as.Date(hpc$Date, format = "%d/%m/%Y")

#Plot 1
hist(hpc$Global_active_power,xlab = "Global Active Power (kilowatts)",col = "RED")
dev.copy(png, file="plot1.png", width=480, height=480)
dev.off()

# Plot 2
with(hpc,plot(as.POSIXct(as.character(paste(hpc$Date,hpc$Time), "%d/%m/%Y %H:%M:%S")),hpc$Global_active_power, type = 'l',xlab = ' '))
dev.copy(png, file="plot2.png", width=480, height=480)
dev.off()

#Plot 3
with(hpc,plot(as.POSIXct(as.character(paste(hpc$Date,hpc$Time), "%d/%m/%Y %H:%M:%S")),hpc$Sub_metering_1, type = 'l',xlab='', ylab = "Energy Sub meetering"))
lines(as.POSIXct(as.character(paste(hpc$Date,hpc$Time), "%d/%m/%Y %H:%M:%S")),hpc$Sub_metering_2, col = "red")
lines(as.POSIXct(as.character(paste(hpc$Date,hpc$Time), "%d/%m/%Y %H:%M:%S")), hpc$Sub_metering_3, col = "blue")
legend("topright", col=c("black","red","blue"), c("Sub_metering_1  ","Sub_metering_2  ", "Sub_metering_3  "),lty=c(1,1), lwd=c(1,1))
dev.copy(png, file="plot3.png", width=480, height=480)
dev.off()

#Plot 4
par(mfrow=c(2,2))
with(hpc,plot(as.POSIXct(as.character(paste(hpc$Date,hpc$Time), "%d/%m/%Y %H:%M:%S")),hpc$Global_active_power, type = 'l',xlab = ' '))
with(hpc, plot(as.POSIXct(as.character(paste(hpc$Date,hpc$Time), "%d/%m/%Y %H:%M:%S")),hpc$Voltage, type="l", xlab="datetime", ylab="Voltage"))

with(hpc,plot(as.POSIXct(as.character(paste(hpc$Date,hpc$Time), "%d/%m/%Y %H:%M:%S")),hpc$Sub_metering_1, type = 'l',xlab='', ylab = "Energy Sub meetering"))
lines(as.POSIXct(as.character(paste(hpc$Date,hpc$Time), "%d/%m/%Y %H:%M:%S")),hpc$Sub_metering_2, col = "red")
lines(as.POSIXct(as.character(paste(hpc$Date,hpc$Time), "%d/%m/%Y %H:%M:%S")), hpc$Sub_metering_3, col = "blue")
legend("topright", col=c("black","red","blue"), c("Sub_metering_1  ","Sub_metering_2  ", "Sub_metering_3  "),lty=c(1,1), bty = "n", y.intersp = .3, cex = .5)

with(hpc, plot(as.POSIXct(as.character(paste(hpc$Date,hpc$Time)), "%d/%m/%Y %H:%M:%S"),hpc$Global_reactive_power, type="l", xlab="datetime", ylab="Global_reactive_power"))

dev.copy(png, file="plot4.png", width=480, height=480)
dev.off()
