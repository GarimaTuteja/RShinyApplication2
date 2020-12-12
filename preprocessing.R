
pacman::p_load(shiny,ggplot2,dplyr,tidyverse,leaflet,VIM,d3heatmap,plotly,GGally,lubridate,RColorBrewer,kableExtra,ggthemes)
crime <- read_csv("Crimes_2020.csv")


#After going through the details of features associated with the data I would like to drop the feature "ID","Case number" as 
#it wont be informational and also the "Block" it basically tells in which block the crime occurred,"description" 
#is just the elaborated version of "primary type", "location", "X Coordinate","Y Coordinate" gives the redundant 
#information that Latitude and Longitude are already giving.

crime <- crime[c(-1,-2,-4,-7,-16,-17,-19,-22)]
crime <- na.omit(crime)

#Now the categorical variables has to be converted to factor variables

crime['Primary Type']<-as.factor(crime$`Primary Type`)
crime['Location Description']<-as.factor(crime$`Location Description`)
crime['Arrest']<-as.factor(crime$`Arrest`)
crime['Domestic']<-as.factor(crime$`Domestic`)

#We need to extract month, date and hour from Date because it will be required in further analysis.

crime$month <- format(as.POSIXct(crime$Date, format = "%m/%d/%Y %H:%M"), "%m")
crime$date_ <- format(as.POSIXct(crime$Date, format = "%m/%d/%Y %H:%M"), "%m/%d/%Y")
crime$hour <- format(as.POSIXct(crime$Date, format = "%m/%d/%Y %H:%M"), "%H")

#To check the missing values in dataset for each column
crime <- na.omit(crime)
sapply(crime ,function(x) sum(is.na(x)))

#Now there are no missing values so we will move forward
