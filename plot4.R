## This script loads the "Electric power consumption" and create the Plot 4
## It is assumed that the file and this script are save in the same directory


## Load the full file "household_power_consumption.txt" in PC data frame.
## Coerce all fields to character to manage the "?"
PC <- read.table("household_power_consumption.txt", sep = ";", header = TRUE, 
                 colClasses = "character")


## Convert Date and Time columns  according to instructions
PC_Date <- as.Date(PC[,"Date"], "%d/%m/%Y") 
PC_Time <- strptime(paste(PC[,"Date"], PC[,"Time"]) , "%d/%m/%Y %H:%M:%S")


## Extract the Variable for plot 4 on 1-2 February 2007.
## Global Active Power, Sub_metering_1/2/3, Blobal Reactive Power 
## Voltage
## Remove question marks and coerce to numeric.
## Extract time and date for x axis
iFeb2007 <- (PC_Date >= as.Date("2007-02-01") & 
                     PC_Date <= as.Date("2007-02-02") &
                     PC[,"Global_active_power"] != "?" &
                     PC[,"Sub_metering_1"] != "?" &
                     PC[,"Sub_metering_2"] != "?" & 
                     PC[,"Sub_metering_3"] != "?" &
                     PC[,"Voltage"] != "?" &
                     PC[,"Global_reactive_power"] != "?")
                             
GAP_Plot4 <- as.numeric(PC[iFeb2007,"Global_active_power"])
Sub1_Plot4 <- as.numeric(PC[iFeb2007,"Sub_metering_1"])
Sub2_Plot4 <- as.numeric(PC[iFeb2007,"Sub_metering_2"])
Sub3_Plot4 <- as.numeric(PC[iFeb2007,"Sub_metering_3"])
V_Plot4 <- as.numeric(PC[iFeb2007,"Voltage"])
GRP_Plot4 <- as.numeric(PC[iFeb2007,"Global_reactive_power"])
DT_Plot4 <- PC_Time[iFeb2007] 


## Draw the required Plot4 in png format in file plot4.png
png(file = "plot4.png")

## Set overall Plot area 2 x 2
par(mfrow = c(2,2))

## Plot the upperleft graph
plot(DT_Plot4,GAP_Plot4, type ="l", xlab = "", 
     ylab ="Global Active Power")

## Plot the upperright graph
plot(DT_Plot4,V_Plot4, type="l", xlab = "datetime", ylab = "Voltage")

## PLot the lowerleft graph
## Set the plot area and Plot Sub1
plot(DT_Plot3,Sub1_Plot3, type ="l", xlab = "", 
     ylab ="Energy sub metering")
## Add Sub2
points(DT_Plot3,Sub2_Plot3, type ="l", col = "red")
## Add Sub3
points(DT_Plot3,Sub3_Plot3, type ="l", col = "blue")
## Add Legend
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       lty = 1, col = c("black", "red", "blue"), bty ="n")

## Plot the lowerright graph
plot(DT_Plot4,GRP_Plot4, type="l", xlab = "datetime", 
     ylab = "Global_reactive_power" )
dev.off()