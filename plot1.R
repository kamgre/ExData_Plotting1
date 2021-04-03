# import data, 
# assuming the data file stays in the working directory under its original name

dataset <- read.csv2('household_power_consumption.txt', 
                     na.strings = c(' ', '?'),
                     colClasses = c('character', 'character', rep('numeric', 7)),
                     dec = '.')

# subset data
dataset <- subset(dataset, Date == '1/2/2007' | Date == '2/2/2007')

# check data structure
head(dataset)
str(dataset)

# initialise png graphics device
png(filename = 'plot1.png')

# create given plot
hist(dataset$Global_active_power,
     col = 'red',
     main = 'Global Active Power',
     xlab = 'Global Active Power (kilowatts)')

# close png graphics device
dev.off()
