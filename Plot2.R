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
df_sel$Global_active_power <- as.numeric(df_sel$Global_active_power)


#select data for plot to represent GAP per weekday
x <- df_sel$DateTime
y <- df_sel$Global_active_power

#plot and save file
plot(x, y, type='l', xlab='', ylab='Golabe Active Power (kilowatts)')
dev.copy(png,filename='Plot2.png', width=480, height=480)
dev.off()