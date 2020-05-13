# open required libraries. Assumes packages already installed.
library("dplyr")

# set local folder
setwd("../ExData_Plotting1")

# read from text file with ; deliminator
df<-read.table("household_power_consumption.txt", header=TRUE, sep=";")

# create smaller subset of data with required fields
df.s<-select(df,Date,Time, Sub_metering_1, Sub_metering_2, Sub_metering_3)

# convert Date to date for filtering
df.s$Date<-as.Date(df.s$Date,format="%d/%m/%Y")

# filter data between  2007/02/01 and 2007/02/02
df.f<-filter(df.s,Date>=as.Date("2007/02/01") & Date<=as.Date("2007/02/02"))

#create Date-Time field 
df.f<- mutate(df.f,DateTime=paste(df.f$Date,df.f$Time))

# convert data formats after filter to optimise conversion time
df.f$DateTime<-as.POSIXct(df.f$DateTime)
df.f$Sub_metering_1<-as.numeric(df.f$Sub_metering_1)
df.f$Sub_metering_2<-as.numeric(df.f$Sub_metering_2)
df.f$Sub_metering_3<-as.numeric(df.f$Sub_metering_3)

#set graphic device to screen
dev.set(2)

#Set size of plot to 480 x 480 pixels
dev.new(Width=480, height=480,unit="px")  

#create main plot
plot(df.f$DateTime,df.f$Sub_metering_1,type="l",xlab="",ylab="Energy sub metering",col=" black")

# overlay additional lines
lines(df.f$DateTime,df.f$Sub_metering_2,col="red",lty=1)
lines(df.f$DateTime,df.f$Sub_metering_3,col="blue",lty=1)

# Add legend
legend("topright",legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),lty=1,col=c("black","red","blue"))

#write to png file
dev.copy(png,file="plot3.png")

#close png graphic device
dev.off()

