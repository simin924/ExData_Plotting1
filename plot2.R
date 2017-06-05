
#read the table
file="household_power_consumption.txt"


power <- read.table(file, header=TRUE, sep=";", na.strings = "?", 
                    colClasses = c('character','character','numeric','numeric','numeric','numeric','numeric','numeric','numeric'))


#as.date
power$Date <- as.Date(power$Date, "%d/%m/%Y")


## select Feb. 1, 2007 to Feb. 2, 2007
power <- subset(power,Date >= as.Date("2007-2-1") & Date <= as.Date("2007-2-2"))

## Remove incomplete observation
power <- power[complete.cases(power),]


## Combine Date and Time 
dateTime <- paste(power$Date, power$Time)


## Name the dateTime
dateTime <- setNames(dateTime, "DateTime")

## select not date and time
library(dplyr)
power <- select(power, -Date)
power <- select(power, -Time)

##combine DateTime and power
power <- cbind(dateTime, power)

## Format dateTime Column
power$dateTime <- as.POSIXct(dateTime)


##plot2
## Create scatterplot
plot(power$Global_active_power~power$dateTime, type="l", 
     ylab="Global Active Power (kilowatts)", xlab="")

## Save file and close device
dev.copy(png,"plot2.png")
dev.off()
