## check if dataset exists in working directory
if (!file.exists("household_power_consumption.txt")) {
	stop("Cannot find dataset, please change your working directory or download the file from https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip")
}

## estimate the memory usage of dataframe: 
## assuming each field will use 8 bytes (date, time, and numeric)
## 2,075,259 rows, 9 columns, and 8 bytes per column: 2075259*9*8=149418648, which is about 145MB
## this should be ok for most computers

#import data frame from household_power_consumption.txt
df <- read.table("household_power_consumption.txt", header=TRUE, sep=";", na.strings="?", stringsAsFactors=FALSE)

#subset: only include data from 1/2/2007 and 2/2/2007
df <- df[df$Date == "1/2/2007" | df$Date == "2/2/2007", ]

#convert Time from character to POSIXlt and Date from character to Date
df$Time <- paste(df$Date,df$Time,sep=" ")
df$Time <- strptime(df$Time, format="%d/%m/%Y %H:%M:%S")
df$Date <- as.Date(df$Date, format="%d/%m/%Y")

##plot4

#create plot on screen device
par(mfcol=c(2,2))
with(df, {
	plot(Time,Global_active_power, type="l", xlab="", ylab="Global Active Power", cex.lab=0.8, cex.axis=0.8)
	plot(Time,Sub_metering_1, type="l", xlab="", ylab="Energy sub metering", cex.lab=0.8, cex.axis=0.8)
		lines(Time,Sub_metering_2, type="l", col="red")
		lines(Time,Sub_metering_3, type="l", col="blue")
		legend("topright", legend=names(df)[7:9], col=c("black", "red", "blue"), bty="n", lwd=1, lty=1, cex=0.7, text.width=80000)
	plot(Time, Voltage, type="l", xlab="datetime", cex.lab=0.8, cex.axis=0.8)
	plot(Time, Global_reactive_power, type="l", xlab="datetime", cex.lab=0.8, cex.axis=0.8)
})
#copy plot to PNG file
dev.copy(png, filename="plot4.png")
#close PNG device
dev.off()
#reset mfcol parameter
par(mfcol=c(1,1))