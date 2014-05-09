powerdata <- read.table("household_power_consumption.txt",
                        skip = 66637, nrow = 2880, sep = ";", 
                        col.names = colnames(read.table(
                          "household_power_consumption.txt",
                          nrow = 1, header = TRUE, sep=";")))

#global column needs to be numeric, comes in as factor
powerdata$Global_active_power <- as.numeric(as.character(powerdata$Global_active_power))

#convert the date / time value into a Posix time format
powerdata$DateTime <- strptime(paste(powerdata[, 'Date'], powerdata[, 'Time']),
                               "%d/%m/%Y %H:%M:%S", tz='CEST')

#kill the old columns (unneeded)
powerdata$Date <- NULL
powerdata$Time <- NULL

png(width = 480, height = 480, units = 'px', filename = 'figure/plot2.png')
plot(powerdata$DateTime, powerdata$Global_active_power, type='l',
     ylab = 'Global Active Power (kilowatts)', xlab = '')
dev.off()