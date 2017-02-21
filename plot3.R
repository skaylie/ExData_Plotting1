#assumes data already downloaded and in the working directory

if(is.null(raw_data)) raw_data <- read.table(unz("exdata%2Fdata%2Fhousehold_power_consumption.zip", "household_power_consumption.txt"), header=T, quote="\"", sep=";")
raw_data$as_date <- as.Date(raw_data$Date, "%d/%m/%Y")

#extract data from 2/1/07 - 2/2/07
test_data <- raw_data[(raw_data$as_date == as.Date("2007-02-02") | raw_data$as_date == as.Date("2007-02-01")), ]

#parse datetimes
test_data$as_time <- strptime(paste(test_data$Date, test_data$Time), "%d/%m/%Y %H:%M:%S")

test_data$Sub_metering_1 <- as.numeric(as.character(test_data$Sub_metering_1))
test_data$Sub_metering_2 <- as.numeric(as.character(test_data$Sub_metering_2))
test_data$Sub_metering_3 <- as.numeric(as.character(test_data$Sub_metering_3))

png(filename = "plot3.png", width=480, height=480)

plot(test_data$as_time, test_data$Sub_metering_1, type = "n", ylab = "Energy sub metering", xlab = "")
lines(test_data$as_time, test_data$Sub_metering_1, type = "l")
lines(test_data$as_time, test_data$Sub_metering_3, type = "l", col = "blue")
lines(test_data$as_time, test_data$Sub_metering_2, type = "l", col = "red")
legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col = c("black","red", "blue"), lty = c(1, 1, 1))
dev.off()