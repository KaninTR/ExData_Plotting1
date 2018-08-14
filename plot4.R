plot4 <- function() {
        
        ##Pre-process1: Check the file and download it if not exist
        dwn_url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
        fil_nme <- "household_power_consumption.txt"
        if(!file.exists(fil_nme)) {
                print("File not exist, download the file")
                download.file(dwn_url, destfile = "elec_data.zip")
                unzip("elec_data.zip")
                dir()
        }
        
        ##Pre-process2: Read the file and store it into object
        library(sqldf)
        library(lubridate)
        query <- 'select * from file where Date == "1/2/2007" or Date == "2/2/2007"'
        elec_data <- read.csv.sql(fil_nme, sql = query, sep = ";", stringsAsFactor = FALSE)
        elec_data$Date <- dmy(elec_data$Date)
        elec_data$Time <- hms(elec_data$Time) + elec_data$Date
        
        ##Plot the 4th figure:
        png("plot4.png", width = 480, height = 480)
        par(mfrow = c(2, 2))
        
                ##TopLeft plot
        with(elec_data, plot(Time, Global_active_power, type = "l", xlab = "",  ylab = "Global Active Power"))
                ##TopRight Plot
        with(elec_data, plot(Time, Voltage, type = "l", xlab = "datetime",  ylab = "Voltage"))
                ##BottomLeft Plot
        with(elec_data, plot(Time, Sub_metering_1, type = "l", xlab = "",  ylab = "Energy sub metering"))
        with(elec_data, lines(Time, Sub_metering_2, col = "red"))
        with(elec_data, lines(Time, Sub_metering_3, col = "blue"))
        leg_col <- c("black", "red", "blue")
        leg_lab <- c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3")
        legend("topright", lty = 1, col = leg_col, legend = leg_lab, bty = "n")
                ##BottomRight Plot
        with(elec_data, plot(Time, Global_reactive_power, type = "l", xlab = "datetime"))
        
        dev.off()
        par(mfrow = c(1, 1))
        
        return("Finish")
}