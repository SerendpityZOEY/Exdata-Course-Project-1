library(sqldf)
mydata<-read.csv("household_power_consumption.txt",header=T,sep=";",
                 stringsAsFactors=F,na.strings="?")

data<-sqldf("select * from mydata where Date='1/2/2007' or Date='2/2/2007'")
Sys.setlocale("LC_TIME","English")
data$Date<-as.Date(data$Date,format="%d/%m/%Y")
DateTime<-strptime(paste(data$Date,data$Time),format="%Y-%m-%d %H:%M:%S")
data$DateTime<-as.POSIXct(DateTime)

png(file="plot2.png",width=480,height=480)
plot(y=data$Global_active_power,x=data$DateTime,type="l",
     ylab="Global Active Power (kilowatts)",xlab="")

dev.off()