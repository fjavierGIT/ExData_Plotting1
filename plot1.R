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
                      sep = ";",na.strings = "?", colClasses = NA)
initial$Date <- as.Date(initial$Date, format ="%d/%m/%Y")
initial$Time <- strptime(initial$Time, "%H:%M:%S")

#We will only be using data from the dates 2007-02-01 and 2007-02-02
initial.filter <- initial[initial$Date >= "2007/02/01" & initial$Date <= "2007/02/02",]

#Draws histogram with desired params
with(initial.filter, 
          hist(Global_active_power,
          col = "red",
          main = "Global Active Power",
          xlab = "Global Active Power (kilowatts)")
)

#Save to png. Defaults (480 x 480) are ok
dev.copy(png, file = "./plot1.png", width = 480, height=480)
dev.off(4)    #close device!
