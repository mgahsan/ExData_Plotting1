## Downloading the file directly from web server and unzipping: The if structure 
## saves time for consecutive uses of the script.

if(!file.exists("exdata-data-household_power_consumption.zip")) {
        download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", 
                      destfile = "exdata-data-household_power_consumption.zip", mode = "wb")
        unzip("exdata-data-household_power_consumption.zip")
}

## Loading the data into R with subsetting for Dates: Takes about 10 seconds on my PC.
## There are few alternatives to this but I wanted to keep the coding platform and external
## package independent for this project. The if structure saves time when used multiple times.

if(!exists("hpcdata")) {
        hpcdata <- subset(read.table("household_power_consumption.txt", header = T, sep =";", na.strings = "?", stringsAsFactors = F), 
                          read.table("household_power_consumption.txt", header = T, sep =";", na.strings = "?", stringsAsFactors = F)$Date %in% c("1/2/2007", "2/2/2007"))
}

## Setting the Date and Time Variables: Format "%F %T" is equivalent of "%Y-%m-%d %H:%M:%S". 
## The new timestamp variable is named "Date_Time".

hpcdata$Date <- as.Date(hpcdata$Date, format = "%d/%m/%Y")
hpcdata$Date_Time <- strptime(paste(hpcdata$Date, hpcdata$Time, sep=" "), format = "%F %T")

## Plotting 4 different plots on one graphic device: The with() function has been 
## used for the convenience of writing codes. Background for the image has been kept
## transparent to math sample images on the GitHub repository. 'mfcol' was used in the
## par() function instead of 'mfrow'. The first column displays plot 2 & 3. The second
## column displays two new plots respectively voltage and global reactive power across
## the time variable. Label names were manipulated a little bit for better presentation.

png("plot4.png", width = 480, height = 480, bg = "transparent")

par(mfcol = c(2, 2)) 

with(hpcdata, {
        
        ## location (col1, row1)
        plot(Date_Time, Global_active_power, type="l", xlab = "", ylab ="Global Active Power")
        
        ## location (col1, row2)
        plot(Date_Time, Sub_metering_1, type = "l", xlab = "", ylab = "Energy Sub-metering")
        lines(Date_Time, Sub_metering_2, col= "Red")
        lines(Date_Time, Sub_metering_3, col= "Blue")
        legend("topright", col = c("black", "red", "blue"), c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lwd = 1.5, bty = "n")
        
        ## location (col2, row1)
        plot(Date_Time, Voltage, type = "l", xlab = "datetime", ylab = "Voltage")
        
        ## location (col2, row2)
        plot(Date_Time, Global_reactive_power, type="l", xlab = "datetime", ylab = "Global Reactive Power")
})

dev.off()