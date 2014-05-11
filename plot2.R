# load library for fread function
library(data.table)

# read all data, replace "?" with NA, ignore "?" warnings
options(warn = -1)
all_data = fread("household_power_consumption.txt",header=TRUE,sep=";", na.strings=c("?"))
options(warn = 0)

# change to Data column
all_data$Date = as.Date(all_data$Date,format="%d/%m/%Y")

# subset relevant data
data = subset(all_data,Date >= as.Date("01/02/2007",format="%d/%m/%Y") & Date <= as.Date("02/02/2007",format="%d/%m/%Y"))

# add Date-Time column
vec = paste(data$Date,data$Time)
vec = strptime(vec, "%Y-%m-%d %H:%M:%S")
data$DateTime = data.frame(vec)

# plot2
png(file="plot2.png",width = 480, height = 480,units="px",bg = "transparent")
plot(data$DateTime,data$Global_active_power,type="l",xlab="",ylab="Global Active Power (kilowatts)")
dev.off()
