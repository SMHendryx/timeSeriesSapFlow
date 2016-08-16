#MULT-SERIES LINE GRAPH FOR PLOTTING TIME-SERIES, SAPFLOW DATA
#	Authored by Sean M. Hendryx
#	While working at The Univerity of Arizona
#	Research funded by the National Science Foundation
#	2016
#	Please cite accordingly
###############################################################################################################

# SET WORKING DIRECTORY
setwd("/your/path/here")

#READ DATA INTO R
tap <- read.csv("C2tap.csv", header=TRUE, sep = ",")
lat1 <- read.csv("C2lat1.csv", header=TRUE, sep = ",")
lat2 <- read.csv("C2lat2.csv", header=TRUE, sep = ",")
trunk <- read.csv("C2trunk.csv", header=TRUE, sep = ",")


#TIMESTAMP DATA
tap$DateTime <- as.POSIXct(paste(tap$Date, tap$Time), format="%m/%d/%y %H:%M:%S")
trunk$DateTime <- as.POSIXct(paste(trunk$Date, trunk$Time), format="%m/%d/%y %H:%M:%S")
lat1$DateTime <- as.POSIXct(paste(lat1$Date, lat1$Time), format="%m/%d/%y %H:%M:%S")
lat2$DateTime <- as.POSIXct(paste(lat2$Date, lat2$Time), format="%m/%d/%y %H:%M:%S")

#SUBSET DATA BY DATE
#If you want to produce a subset of the whole time-series
#stap <- subset(tap, DateTime >= as.POSIXct('2015-08-22 0:01:00'))
#strunk <- subset(trunk, DateTime >= as.POSIXct('2015-08-22 0:01:00'))
#slat1 <- subset(lat1, DateTime >= as.POSIXct('2015-08-22 0:01:00'))
#slat2 <- subset(lat2, DateTime >= as.POSIXct('2015-08-22 0:01:00'))

#ASSIGN COLUMNS TO VARIABLES
#Corrected.Out..cm.hr. are hardware-generated columns names as read by R
#of course, change to your hardware-generated or user-input column names as needed
tapy <- tap$Corrected.Out..cm.hr.
trunky <- trunk$Corrected.Out..cm.hr.
lat1y <- lat1$Corrected.Out..cm.hr.
lat2y <- lat2$Corrected.Out..cm.hr.
tapx <- tap$DateTime
trunkx <- trunk$DateTime
lat1x <- lat1$DateTime
lat2x <- lat2$DateTime



#PLOT DATA
plot(tapx, tapy, type="l", col="blue", xlab= "Date", ylab= "Sap Velocity in cm/hr", main=" Tree Sap Velocity Readings at Outer Thermistors Over Time")
lines(lat1x, lat1y, col="orange")
lines(lat2x, lat2y, col="red")
lines(trunkx, trunky, col="green")

#ADD LEGEND
legend("topright", c("Tap", "Trunk", "Lat2", "Lat1"), col=c("blue", "green", "red", "orange"), title = NULL, lty = 1)



