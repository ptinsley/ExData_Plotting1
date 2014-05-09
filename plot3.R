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

#assignment asks for 480x480 but samples were 504x504, going with assignment specs over samples
png(width = 480, height = 480, units = 'px', filename = 'figure/plot3.png')
#plot first line
plot(powerdata[,'DateTime'], powerdata[,'Sub_metering_1'], type='l', col='black',
     xlab = '', ylab = 'Energy sub metering')
#add additional lines
lines(powerdata[,'DateTime'], powerdata[,'Sub_metering_2'], col='red')
lines(powerdata[,'DateTime'], powerdata[,'Sub_metering_3'], col='blue')
#add a legend with colored reference lines
legend('topright',,c('Sub_metering_1', 'Sub_metering_2', 'Sub_metering_3'), 
       col = c('black', 'red', 'blue'), lty = c(1,1,1))
dev.off()