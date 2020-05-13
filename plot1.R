# open required libraries. Assumes packages already installed.
library("dplyr")

# set local folder
setwd("../ExData_Plotting1")

# read from text file with ; deliminator
df<-read.table("household_power_consumption.txt", header=TRUE, sep=";")

# create smaller subset of data with required fields
df.s<-select(df,Date,Global_active_power)

# convert Date to date for filtering
df.s$Date<-as.Date(strptime(df.s$Date,"%d/%m/%Y"))

# filter data between  2007/02/01 and 2007/02/02
df.f<-filter(df.s,Date>=as.Date("2007/02/01") & Date<=as.Date("2007/02/02"))

# convert data format after filter to optimise conversion time
df.f$Global_active_power<-as.numeric(df.f$Global_active_power)

#set graphic device to screen
dev.set(2)

#Set size of plot to 480 x 480 pixels
dev.new(Width=480, height=480,unit="px")       

# plot histogram
hist(df.f$Global_active_power,xlab="Global Active Power (kilowatts)",ylab="Frequency",col="red",main="Global Active Power",breaks=12)

#write to png file
dev.copy(png,file="plot1.png")

#close png graphic device
dev.off()
