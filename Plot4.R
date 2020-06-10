#load packages
library(dplyr)
library(lubridate)
#load date and read it as table

df <- read.table('household_power_consumption.txt', header=TRUE, sep=';')

# convert dates and times to date and time formats
df$Date <- dmy(df$Date)
df$Time <- hms(df$Time)
df <- mutate(df, DateTime= df$Date+df$Time)

#select the data only for 2007-02-01 and 2007-02-02
df_sel <- df[df$Date=='2007-02-01' | df$Date=='2007-02-02',]

#replace all values with '?' to NA 
df_sel[,3:9] <- replace(df_sel[,3:9], df_sel[,3:9]== '?', NA)

#convert to numeric
df_sel_metingen <- mutate(df_sel, met1=as.numeric(df_sel$Sub_metering_1), met2=as.numeric(df_sel$Sub_metering_2),met3=as.numeric(df_sel$Sub_metering_3))


#select data for plot to represent variables per weekday
x <- df_sel$DateTime
y1 <- df_sel_metingen$met1
y2 <- df_sel_metingen$met2
y3 <- df_sel_metingen$met3

#prepare the grid for plotting
par(mfrow=c(2,2), mar = c(4, 4, 2, 1))
#plot 1 
plot(x, y, type='l', xlab='', ylab='Golabe Active Power (kilowatts)')
#plot 2
plot(x, as.numeric(df_sel$Voltage), type='l', xlab='DateTime', ylab='Voltage')
#plot 3
plot(x, y1, type='l', xlab='', ylab='Energy Sub Metering', col='black')
points(x, y2, type='l', xlab='', col='red')
points(x, y3, type='l', xlab='', col='blue')
legend('topright',bty='n',legend=names(df_sel)[7:9], col=c('black','red','blue'), lty=1, cex=0.7)
#plot 4
plot(x, as.numeric(df_sel$Global_reactive_power), type='l', xlab='DateTime', ylab='Global_reactive_power')
dev.copy(png,filename='Plot4.png', width=480, height=480)
dev.off()