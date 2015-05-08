library(sqldf)
mydata<-read.table("household_power_consumption.txt",header=T,sep=";",
                   stringsAsFactors=F,na.strings="?")

data<-sqldf("select * from mydata where Date='1/2/2007' or Date='2/2/2007'")

Sys.setlocale("LC_TIME","English")
data$Date<-as.Date(data$Date,format="%d/%m/%Y")
DateTime<-strptime(paste(data$Date,data$Time),format="%Y-%m-%d %H:%M:%S")
data$DateTime<-as.POSIXct(DateTime)

png(file="plot3.png",width=480,height=480)
with(data,{
  plot(Sub_metering_1~DateTime,type="l",
       ylab="Energy sub metering")
  lines(Sub_metering_2~DateTime,col="red")
  lines(Sub_metering_3~DateTime,col="blue")
})
     
legend("topright",col=c("black","red","blue"),lty=1,lwd=2
       legend=c("Sub_metering_1","Sub_metering_2",
                "Sub_metering_3"))
dev.off()
