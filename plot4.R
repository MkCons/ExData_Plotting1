library(dplyr)
data <- read.table("household_power_consumption.txt",header=TRUE, sep=";", na.strings="?", stringsAsFactors=FALSE)
subdata <- data[(data$Date == "1/2/2007" | data$Date == "2/2/2007"),]
rm(data)
power<-tbl_df(subdata)
## concatenate date and time
power = mutate(power, Date_Time = paste(Date, Time, sep=" "))
## drop the old columns
power<-select(power, Date_Time, Global_active_power:Sub_metering_3)
## transform the strings into date objects
power$Date_Time <- strptime(power$Date_Time, format="%d/%m/%Y %H:%M:%S")
## set locales otherwise we get the day of the week OS locale
Sys.setlocale("LC_TIME", "C")

png(file = "ExData_Plotting1/plot4.png", bg = "transparent")
par(mfrow = c(2,2))
## global active power
plot(power$Date_Time, power$Global_active_power , type="l", main = "", xlab="", ylab="Global Active Power")

## voltage
plot(power$Date_Time, power$Voltage , type="l", main = "", xlab="datetime", ylab="Voltage")

## submetering
plot(power$Date_Time, power$Sub_metering_1 , type="n", main = "", xlab="", ylab="Energy sub metering")
points(power$Date_Time, power$Sub_metering_1, type="l", col = "black")
points(power$Date_Time, power$Sub_metering_2, type="l", col = "red")
points(power$Date_Time, power$Sub_metering_3, type="l", col = "blue")
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col=c("black", "red", "blue"), lty = 1)

## global reactive
plot(power$Date_Time, power$Global_reactive_power , type="l", main = "", xlab="datetime", ylab="Global_reactive_power")

dev.off()
