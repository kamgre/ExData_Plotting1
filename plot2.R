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
png(filename = 'plot2.png')

# create given plot
with(dataset, {
   plot(DateTime, Global_active_power,
        type = 'n',
        main = '',
        xlab = '',
        ylab = 'Global Active Power (kilowatts)')
   lines(DateTime, Global_active_power)
   })

# close png graphics device
dev.off()

