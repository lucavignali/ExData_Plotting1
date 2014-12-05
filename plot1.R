## This script loads the "Electric power consumption" and create the Plot 1
## It is assumed that the file and this script are save in the same directory


## Load the full file "household_power_consumption.txt" in PC data frame.
## Coerce all fields to character to manage the "?"
PC <- read.table("household_power_consumption.txt", sep = ";", header = TRUE, 
                 colClasses = "character")


## Convert Date according to instructions
PC_Date <- as.Date(PC[,"Date"], "%d/%m/%Y") 


## Extract the Variable for plot 1. Global Active Power in 1-2 February 2007.
## Remove question marks and coerce to numeric.
iFeb2007 <- (PC_Date >= as.Date("2007-02-01") & 
                     PC_Date <= as.Date("2007-02-02") & 
                     PC[,"Global_active_power"] != "?")
GAP_Plot1 <- as.numeric(PC[iFeb2007,"Global_active_power"]) 


## Draw the required Plot1 in png format in file plot1.png
png(file = "plot1.png")
hist(GAP_Plot1, col="red", main="Global Active Power", 
     xlab = "Global Active Power (kilowatts)")
dev.off()