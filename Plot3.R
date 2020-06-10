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

#plot and save file
plot(x, y1, type='l', xlab='', ylab='Energy Sub Metering', col='black')
points(x, y2, type='l', xlab='', col='red')
points(x, y3, type='l', xlab='', col='blue')
legend('topright',legend=names(df_sel)[7:9], col=c('black','red','blue'), lty=1)
dev.copy(png,filename='Plot3.png', width=480, height=480)
dev.off()