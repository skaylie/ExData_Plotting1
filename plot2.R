#assumes data already downloaded and in the working directory

if(is.null(raw_data)) raw_data <- read.table(unz("exdata%2Fdata%2Fhousehold_power_consumption.zip", "household_power_consumption.txt"), header=T, quote="\"", sep=";")
raw_data$as_date <- as.Date(raw_data$Date, "%d/%m/%Y")

#extract data from 2/1/07 - 2/2/07
test_data <- raw_data[(raw_data$as_date == as.Date("2007-02-02") | raw_data$as_date == as.Date("2007-02-01")), ]

#parse datetimes
test_data$as_time <- strptime(paste(test_data$Date, test_data$Time), "%d/%m/%Y %H:%M:%S")

test_data$Global_active_power <- as.numeric(as.character(test_data$Global_active_power))

png(filename = "plot2.png", width=480, height=480)
plot(test_data$as_time, test_data$Global_active_power, type = "n", ylab = "Global Active Power (kilowatts)", xlab = "")
lines(test_data$as_time, test_data$Global_active_power, type = "l")
dev.off()