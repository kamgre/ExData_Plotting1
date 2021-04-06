# IMPORTANT: my locale (Polish) affects the x scale labels in result file

# import data, 
# assuming the data file stays in the working directory under its original name

dataset <- read.csv2('household_power_consumption.txt', 
                     na.strings = c(' ', '?'),
                     colClasses = c('character', 'character', rep('numeric', 7)),
                     dec = '.')

# subset data
dataset <- subset(dataset, Date == '1/2/2007' | Date == '2/2/2007')

# concatenate date & time, convert to POSIXct class
dataset$DateTime <- as.POSIXct(paste(dataset$Date, dataset$Time), format = '%d/%m/%Y %T')

# check data structure
head(dataset)
str(dataset)

# open png graphics device
png(filename = 'plot4.png')

# prepare graph layout
par(mfcol = c(2, 2))


# create first subplot
with(dataset, {
   plot(x = dataset$DateTime,
        y = dataset$Global_active_power,
        type = 'n',
        main = '',
        xlab = '',
        ylab = 'Global Active Power (kilowatts)')
   lines(DateTime, Global_active_power)
   })


# create second subplot
with(dataset, {
   plot(DateTime, Sub_metering_1, 
        type = 'n', 
        main = '',
        ylim = c(0, max(Sub_metering_1, Sub_metering_2, Sub_metering_3)),
        xlab = '',
        ylab = 'Energy sub metering'
        )
   lines(DateTime, Sub_metering_1)
   lines(DateTime, Sub_metering_2, col = 'red')
   lines(DateTime, Sub_metering_3, col = 'blue')
   })

legend('topright',
       bty = 'n',
       col = c('black', 'red', 'blue'),
       lty = c(1, 1, 1),
       c('Sub_metering_1', 'Sub_metering_2', 'Sub_metering_3'))

# create third subplot
with(dataset, {
   plot(DateTime, Voltage,
        type = 'n')
   lines(DateTime, Voltage)
   })

# create fourth subplot
with(dataset, {
   plot(DateTime, Global_reactive_power,
        type = 'n')
   lines(DateTime, Global_reactive_power)
   })

# close png graphics device
dev.off()
