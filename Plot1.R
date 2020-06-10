#load date and read it as table

df <- read.table('household_power_consumption.txt', header=TRUE, sep=';')

# convert dates and times to date and time formats
df$Date <- as.Date(df$Date, format='%d/%m/%Y')
df$Time <- as.POSIXlt(df$Time, format='%H:%M:%S')

#select the data only for 2007-02-01 and 2007-02-02
df_sel <- df[df$Date=='2007-02-01' | df$Date=='2007-02-02',]

#replace all values with '?' to NA 
df_sel <- replace(df_sel[,3:9], df_sel[,3:9]== '?', NA)

#convert to numeric
df_sel$Global_active_power <- as.numeric(df_sel$Global_active_power)

#plot
hist(df_sel$Global_active_power, col='red', xlab='Global active power (kilowatts)', xlim = range(0,6), main='Global active power')
png(filename='Plot1.png', width=480, height=480)
dev.off()