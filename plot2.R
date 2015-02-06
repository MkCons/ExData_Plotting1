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

png(file = "ExData_Plotting1/plot2.png", bg = "transparent")
plot(power$Date_Time, power$Global_active_power , type="l", main = "", xlab="", ylab="Global Active Power (kilowatts)")
dev.off()
