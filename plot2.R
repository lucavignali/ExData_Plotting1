## This script loads the "Electric power consumption" and create the Plot 2
## It is assumed that the file and this script are save in the same directory


## Load the full file "household_power_consumption.txt" in PC data frame.
## Coerce all fields to character to manage the "?"
PC <- read.table("household_power_consumption.txt", sep = ";", header = TRUE, 
                 colClasses = "character")


## Convert Date and Time columns  according to instructions
PC_Date <- as.Date(PC[,"Date"], "%d/%m/%Y") 
PC_Time <- strptime(paste(PC[,"Date"], PC[,"Time"]) , "%d/%m/%Y %H:%M:%S")


## Extract the Variable for plot 2. Global Active Power in 1-2 February 2007.
## Remove question marks and coerce to numeric.
## Extract time and date for x axis
iFeb2007 <- (PC_Date >= as.Date("2007-02-01") & 
                     PC_Date <= as.Date("2007-02-02") & 
                     PC[,"Global_active_power"] != "?")
GAP_Plot2 <- as.numeric(PC[iFeb2007,"Global_active_power"])
DT_Plot2 <- PC_Time[iFeb2007] 


## Draw the required Plot2 in png format in file plot2.png
png(file = "plot2.png")
plot(DT_Plot2,GAP_Plot2, type ="l", xlab = "", 
     ylab ="Global Active Power (kilowatts)")
dev.off()