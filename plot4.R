## Loads packages
library("httr")

## Downloads to working directory
fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fileUrl, destfile = "./assignDataset.zip", 
              method = "auto")

## Extracts dataset into working directory
unzip("./assignDataset.zip", exdir = ".")

#Reads File to data frame
#2,075,259 rws × 9 cls × 8 bytes/numeric = 149418648 bytes
#149418648 / 2^20 = 142,49 MB memory required
initial <- read.table("./household_power_consumption.txt", 
                      header = TRUE, 
                      sep = ";",na.strings = "?", 
                      colClasses = c("character", "character",rep("numeric",7)))
#Adds a column for Date+Time data 
initial[,"DateTime"] <- NA
initial$DateTime <- strptime(paste(initial$Date, initial$Time, sep=" "), "%d/%m/%Y %H:%M:%S")

#We will only be using data from the dates 2007-02-01 and 2007-02-02
initial.filter <- initial[initial$DateTime >= "2007/02/01" & initial$DateTime < "2007/02/03",]

#Save to png
png("./plot4.png", width=480, height=480)

#Prepare layout
par(mfrow = c(2, 2)) 

#Draws graph1 with desired params
with(initial.filter, plot(DateTime, Global_active_power, 
                          type="l", xlab="", ylab="Global Active Power"))

#Draws graph2 with desired params
with(initial.filter, 
     plot(DateTime, Sub_metering_1, type = "n",
          xlab="", ylab="Energy sub metering"))
with(initial.filter,lines(DateTime, Sub_metering_1, col="black"))
with(initial.filter,lines(DateTime, Sub_metering_2, col="red"))
with(initial.filter,lines(DateTime, Sub_metering_3, col="blue"))
legend("topright", col = c("black","red", "blue"), lty = 1, cex= 0.9,
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), bty="n")

#Draws graph3 with desired params
with(initial.filter, plot(DateTime, Voltage, 
                          type="l", xlab="datetime", ylab="Voltage"))

#Draws graph4 with desired params
with(initial.filter, plot(DateTime, Global_reactive_power, 
                          type="l", xlab="datetime"))

dev.off()    #close device!
