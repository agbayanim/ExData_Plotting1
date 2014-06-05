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

##plot1

#create plot on screen device
with(df, hist(Global_active_power, col="red", main="Global Active Power", xlab="Global Active Power (kilowatts)"))
#copy plot to PNG file
dev.copy(png, filename="plot1.png", width=480, height=480, units="px")
#close PNG device
dev.off()
