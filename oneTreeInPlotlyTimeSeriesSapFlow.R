#	Interactive Plotly Display 
#MULT-SERIES LINE GRAPH FOR PLOTTING TIME-SERIES, SAPFLOW DATA
#   Authored by Sean M. Hendryx
#   While working at The Univerity of Arizona
#   Research funded by the National Science Foundation
#   2016
#   Please cite accordingly
###############################################################################################################
library(plotly)

# SET WORKING DIRECTORY
setwd("/file/path/here")

#READ DATA INTO R
tap <- read.csv("C3tap.csv", header=TRUE, sep = ",")
lat1 <- read.csv("C3lat1.csv", header=TRUE, sep = ",")
lat2 <- read.csv("C3lat2.csv", header=TRUE, sep = ",")
trunk <- read.csv("C3trunk.csv", header=TRUE, sep = ",")

#TIMESTAMP DATA
tap$DateTime <- as.POSIXct(paste(tap$Date, tap$Time), format="%m/%d/%y %H:%M:%S")
trunk$DateTime <- as.POSIXct(paste(trunk$Date, trunk$Time), format="%m/%d/%y %H:%M:%S")
lat1$DateTime <- as.POSIXct(paste(lat1$Date, lat1$Time), format="%m/%d/%y %H:%M:%S")
lat2$DateTime <- as.POSIXct(paste(lat2$Date, lat2$Time), format="%m/%d/%y %H:%M:%S")

#ASSIGN COLUMNS TO VARIABLES
#Corrected.Out..cm.hr. are hardware-generated columns names as read by R
#of course, change to your hardware-generated or user-input column names as needed
tapy <- tap$Corrected.Out..cm.hr.
trunky <- trunk$Corrected.Out..cm.hr.
lat1y <- lat1$Corrected.Out..cm.hr.
lat2y <- lat2$Corrected.Out..cm.hr.
tapx <- tap$DateTime
trunkx <- trunk$DateTime
lat1x <-lat1$DateTime
lat2x <- lat2$DateTime



#PLOT DATA
p <- plot_ly(x = lat2x, y = lat2y, 

  name = "Lateral Root 2",  # more about scatter's "name": /r/reference/#scatter-name
  marker = list(          # marker is a named list, valid keys: /r/reference/#scatter-marker
    color="rgb(255,0,0)"
  ))



p <- add_trace(p, x = lat1x, y = lat1y,
    name = "Lateral Root 1",  # scatter's "y": /r/reference/#scatter-y
  line = list(                        # line is a named list, valid keys: /r/reference/#scatter-line
    color = "rgb(255,140,0)"      # line's "color": /r/reference/#scatter-line-color

  )
)

p <- add_trace(p, x = tapx, y = tapy,
    name = "Tap Root",  
  line = list(                        
  color = "rgb(0,0,255)"      

    )
)

p <- add_trace(p, x = trunkx, y = trunky,
    name = "Trunk Root",  
  line = list(                        
    color = "rgb(0,255, 0)"      

  )
)
p
