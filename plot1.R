powerdata <- read.table('household_power_consumption.txt', sep = ';', header = TRUE)

powerdata$Global_active_power <- as.numeric(powerdata$Global_active_power)

#convert the date / time value into a Posix time format
powerdata$DateTime <- strptime(paste(powerdata[, 'Date'], powerdata[, 'Time']), "%d/%m/%Y %H:%M:%S")

#kill the old columns
powerdata$Date <- NULL
powerdata$Time <- NULL

#filter down to the dates we care about 02/01/2007 - 02/02/2007get
powerdata <- powerdata[powerdata$DateTime >= as.POSIXct('2007-02-01') &
            powerdata$DateTime < as.POSIXct('2007-02-03'),]

png(width = 480, height = 480, units = 'px', filename = 'figure/plot1.png')
hist(powerdata$Global_active_power, col='red', xlab = 'Global Active Power (kilowatts)', main = 'Global Active Power')
dev.off()