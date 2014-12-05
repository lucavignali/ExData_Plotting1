## This script loads the "Electric power consumption" and create the Plot 3
## It is assumed that the file and this script are save in the same directory


## Load the full file "household_power_consumption.txt" in PC data frame.
## Coerce all fields to character to manage the "?"
PC <- read.table("household_power_consumption.txt", sep = ";", header = TRUE, 
                 colClasses = "character")


## Convert Date and Time columns  according to instructions
PC_Date <- as.Date(PC[,"Date"], "%d/%m/%Y") 
PC_Time <- strptime(paste(PC[,"Date"], PC[,"Time"]) , "%d/%m/%Y %H:%M:%S")


## Extract the Variable for plot 3. Sub_metering_1/2/3 on 1-2 February 2007.
## Remove question marks and coerce to numeric.
## Extract time and date for x axis
iFeb2007 <- (PC_Date >= as.Date("2007-02-01") & 
                     PC_Date <= as.Date("2007-02-02") & 
                     PC[,"Sub_metering_1"] != "?" &
                     PC[,"Sub_metering_2"] != "?" & 
                     PC[,"Sub_metering_3"] != "?") 
Sub1_Plot3 <- as.numeric(PC[iFeb2007,"Sub_metering_1"])
Sub2_Plot3 <- as.numeric(PC[iFeb2007,"Sub_metering_2"])
Sub3_Plot3 <- as.numeric(PC[iFeb2007,"Sub_metering_3"])
DT_Plot3 <- PC_Time[iFeb2007] 


## Draw the required Plot3 in png format in file plot3.png
png(file = "plot3.png")
## Set the plot area and Plot Sub1
plot(DT_Plot3,Sub1_Plot3, type ="l", xlab = "", 
     ylab ="Energy sub metering")
## Add Sub2
points(DT_Plot3,Sub2_Plot3, type ="l", col = "red")
## Add Sub3
points(DT_Plot3,Sub3_Plot3, type ="l", col = "blue")
## Add Legend
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       lty = 1, col = c("black", "red", "blue"))
dev.off()