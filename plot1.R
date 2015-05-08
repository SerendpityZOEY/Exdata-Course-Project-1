## Read the raw data

mydata <- read.table("household_power_consumption.txt", header=T, sep=';', 
                     na.strings="?",check.names=F, stringsAsFactors=F, 
                     comment.char="", quote='\"')
                     
## Subset the data

data<-sqldf("select * from mydata where Date='1/2/2007' or Date='2/2/2007'")

## Plot1
hist(data$Global_active_power,col="red",
     main="Global Active Power",
     xlab="Global Active Power (kilowatts)")

dev.copy(png,file="plog1.png",width=480,height=480)
dev.off()
