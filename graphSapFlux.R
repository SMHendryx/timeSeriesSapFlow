#	MULT-SERIES LINE GRAPH FOR PLOTTING TIME-SERIES, SAPFLUX DATA
# Interactive Plotly Display 
#	Authored by Sean Hendryx
#	While working at The Univerity of Arizona
#	2016
# This script has been updated from previous work to pull out data of interest from a directory containing files from individual sensors
# Data from sap flow meters must usually be pre-cleaned to remove extra header information at the beginning and inserted in the data stream throughout
# Start with clear workspace in R
###############################################################################################################
library(ggplot2)
library(plotly)
library(dplyr)
library(tools)

# SET WORKING DIRECTORY
setwd("/Users/seanhendryx/DATA/sapFlowData/Charleston/compiledSapFlowData20160816")
fileList <- list.files()

#Read data into R, time stamp data (in month/day/year hour:minute:second, add group/location id, select columns of interest and return in new dataframe
grabber <- function(file){
  df <- read.table(file, header = TRUE, sep = ",", fileEncoding="latin1", skip = 17)
  df$DateTime <- as.POSIXct(paste(df$Date, df$Time), format="%m/%d/%y %H:%M:%S")
  df$id <- file_path_sans_ext(file)
  newdf <- select(df, DateTime, Uncorrected.Out..cm.hr., id)
  return(newdf)
}

#Extract with grabber and rbind data together into single df
for (i in 1:length(fileList)){
  if (i == 1) df <- grabber(fileList[i])
  else {
    tempdf <- grabber(fileList[i])
    df <-rbind(df, tempdf)
  }
}

#Plot data
#Make qualitative color palettes
cols = rainbow(26, s=.6, v=.9)[sample(1:16,16)]
#Or
# From http://tools.medialab.sciences-po.fr/iwanthue/:
iwanthue <- c("#4f7938",
"#693cc2",
"#6eb943",
"#d14fc8",
"#66b18d",
"#d44675",
"#775a27",
"#7577d3",
"#d45130",
"#5d9fc8",
"#7f3436",
"#c888bb",
"#c5a03f",
"#772e73",
"#d18a72",
"#4b4678")

morebrights <- c("#6b7ad3",
"#99d446",
"#753fcf",
"#6ece85",
"#c367d8",
"#cfa03c",
"#5c338b",
"#caca97",
"#d44944",
"#77c8c7",
"#783b2e",
"#a3a7d3",
"#586d30",
"#4d4d75",
"#cd887d",
"#48685e")

brighterBrights <- c("#6aac49",
"#db55e2",
"#5adb61",
"#d178d4",
"#a9e243",
"#8783ec",
"#dbcd3d",
"#6aa4db",
"#dd8b31",
"#57cdcb",
"#ec6165",
"#6fcc96",
"#cb97cf",
"#d1e08f",
"#d7936f",
"#a49e4e") 

ggp <- ggplot(data = df, aes(x= DateTime, y = Uncorrected.Out..cm.hr.)) + geom_line(aes(colour = id)) + theme_bw()+ labs(x = "Date", y = "Uncorrected Sap Velocity (cm per hr)") + ggtitle("Sap Velocity Estimated from Uncorrected HRM at Charleston Mesquite")
ggp <- ggp + scale_colour_manual(values=brighterBrights)
ggp

p <- ggplotly(ggp)
p


