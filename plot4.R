library(sqldf)
mydata<-read.table("household_power_consumption.txt",header=T,sep=";",
                   stringsAsFactor=F,na.strings="?")

data<-sqldf("select * from mydata where Date='1/2/2007' or Date='2/2/2007'")

Sys.setlocale("LC_TIME","English")
data$Date<-as.Date(data$Date,format="%d/%m/%Y")
DateTime<-strptime(paste(data$Date,data$Time),format="%Y-%m-%d %H:%M:%S")
data$DateTime<-as.POSIXct(DateTime)

png(file="plot4.png",width=480,height=480)
par(mfrow=c(2,2),mar=c(5,4,2,1),oma=c(0,0,2,0))
with(data,{
  plot(Global_active_power~DateTime,
       ylab="Global Active Power",xlab="",type="l")
  plot(Voltage~DateTime,
       ylab="Voltage",xlab="datetime",type="l")
  plot(Sub_metering_1~DateTime,type="l",
       ylab="Energy sub metering",xlab="")
  lines(Sub_metering_2~DateTime,type="l",
        col="red")
  lines(Sub_metering_3~DateTime,type="l",
        col="blue")
  legend("topright",col=c("black","red","blue"),lty=1,lwd=2,bty="n",
         legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))
  plot(Global_reactive_power~DateTime,type="l",
       ylab="Global_reactive_power",xlab="datetime")
})

dev.off()
