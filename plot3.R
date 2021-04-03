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
png(filename = 'plot3.png')

# create given plot
plot(x = dataset$DateTime,
     y = dataset$Sub_metering_3,
     type = 'n',
     main = '',
     ylim = c(0, max(dataset$Sub_metering_1, dataset$Sub_metering_2, dataset$Sub_metering_3)),
     xlab = '',
     ylab = 'Energy sub metering')

lines(x = dataset$DateTime,
      y = dataset$Sub_metering_1)

lines(x = dataset$DateTime,
      y = dataset$Sub_metering_2,
      col = 'red')

lines(x = dataset$DateTime,
      y = dataset$Sub_metering_3,
      col = 'blue')

legend('topright',
       col = c('black', 'red', 'blue'),
       lty = c(1, 1, 1),
       c('Sub_metering_1', 'Sub_metering_2', 'Sub_metering_3'))

# close png graphics device
dev.off()
