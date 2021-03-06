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
initial <- read.table("./household_power_consumption.txt", header = TRUE, 
                      sep = ";",na.strings = "?", colClasses = c("character", "character",rep("numeric",7)))
#Adds a column for Date+Time data
initial[,"DateTime"] <- NA
initial$DateTime <- strptime(paste(initial$Date, initial$Time, sep=" "), "%d/%m/%Y %H:%M:%S")

#We will only be using data from the dates 2007-02-01 and 2007-02-02
initial.filter <- initial[initial$DateTime >= "2007/02/01" & initial$DateTime < "2007/02/03",]

#Save to png
png("./plot2.png", width=480, height=480)

#Draws plot with desired params
with(initial.filter, plot(DateTime, Global_active_power, 
                          type="l", xlab="", ylab="Global Active Power (kilowatts)"))

dev.off()    #close device!
