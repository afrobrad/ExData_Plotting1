# open required libraries. Assumes packages already installed.
library("dplyr")

# set local folder
setwd("../ExData_Plotting1")

# read from text file with ; deliminator
df<-read.table("household_power_consumption.txt", header=TRUE, sep=";")

# convert Date to date for filtering
df$Date<-as.Date(df$Date,format="%d/%m/%Y")

# filter data between  2007/02/01 and 2007/02/02
df.f<-filter(df,Date>=as.Date("2007/02/01") & Date<=as.Date("2007/02/02"))

#create Date-Time field 
df.f<- mutate(df.f,DateTime=paste(df.f$Date,df.f$Time))

# convert data formats after filter to optimise conversion time
df.f$DateTime<-as.POSIXct(df.f$DateTime)
df.f$Global_reactive_power<-as.numeric(df.f$Global_reactive_power)
df.f$Voltage<-as.numeric(df.f$Voltage)
df.f$Sub_metering_1<-as.numeric(df.f$Sub_metering_1)
df.f$Sub_metering_2<-as.numeric(df.f$Sub_metering_2)
df.f$Sub_metering_3<-as.numeric(df.f$Sub_metering_3)

#set graphic device to screen
dev.set(2)

#Set size of plot to 480 x 480 pixels
dev.new(Width=480, height=480,unit="px")   

# set grid to 2x2
par(mfrow=c(2,2))

# plot top left
    plot(df.f$DateTime,df.f$Global_active_power,type="l",xlab="",ylab="Global Active Power",col=" black")

# plot top right
    plot(df.f$DateTime,df.f$Voltage,type="l",xlab="datetime",ylab="Voltage", col=" black")
    
# plot bottom left
    # Main plot
    plot(df.f$DateTime,df.f$Sub_metering_1,type="l",xlab="",ylab="Energy sub metering",col=" black")
    
    # overlay additional lines
    lines(df.f$DateTime,df.f$Sub_metering_2,col="red",lty=1)
    lines(df.f$DateTime,df.f$Sub_metering_3,col="blue",lty=1)
    
    # add legend
    legend("topright",legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),lty=1,col=c("black","red","blue"),bty="n")

# plot bottom right
    plot(df.f$DateTime,df.f$Global_reactive_power,type="l",xlab="datetime",ylab="Global_reactive_power",col=" black")

#write to png file
dev.copy(png,file="plot4.png")

#close png graphic device
dev.off()

