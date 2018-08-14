plot1 <- function() {
        
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
        
        ##Plot the 1st figure:
        png("plot1.png", width = 480, height = 480)
        
        with(elec_data, hist(Global_active_power, col = "red", xlab = "Global Active Power (kilowatts)", main = "Global Active Power"))
        
        dev.off()
        
        return("Finish")
}