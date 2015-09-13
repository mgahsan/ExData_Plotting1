## Note: The script will run on the working directory of the user. Any new file downloaded,
## manipulated or created will be saved on the same location.

## Downloading the file directly from web and unzipping: The if structure saves time on 
## consecutive uses of the script.

if(!file.exists("exdata-data-household_power_consumption.zip")) {
        download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", 
                      destfile = "exdata-data-household_power_consumption.zip", mode = "wb")
        unzip("exdata-data-household_power_consumption.zip")
}

## Loading the data into R with subsetting for Dates: Takes about 10 seconds on my PC.
## There are few alternatives to this but I wanted to keep the coding platform and external
## package independent for this project. The if structure saves time when used multiple times.

if(!exists("hpcdata")) {
hpcdata <- subset(read.table("household_power_consumption.txt", 
                             header = T, sep =";", na.strings = "?", stringsAsFactors = F), 
                  read.table("household_power_consumption.txt", 
                             header = T, sep =";", na.strings = "?", stringsAsFactors = F)$Date %in% c("1/2/2007", "2/2/2007"))
}

## Setting the Date and Time Variables (not necessary for plot1): Format "%F %T" is 
## equivalent of "%Y-%m-%d %H:%M:%S". The new timestamp variable is named "Date_Time".

hpcdata$Date <- as.Date(hpcdata$Date, format = "%d/%m/%Y")
hpcdata$Date_Time <- strptime(paste(hpcdata$Date, hpcdata$Time, sep=" "), format = "%F %T")

## Plotting histogram for Global Active Power: Background for the image has been kept
## transparent to math sample images on the GitHub repository.

## Minor structural differences might be observed because of platform differences. The
## sample png files were created on Mac operating system probably by using the "quarts"
## graphical device. The closest possible option to match them on windows platform is to
## use 'cairo' or 'cairo-png' type. Playing with resolution ends up changing the sizes of 
## the plots. It was avoided here. The 'antialias' argument was used to produce clarity 
## of fonts and graphs.

png("plot1.png", width = 480, height = 480, unit = "px", res = 72, bg = "transparent", type = "cairo", antialias = "subpixel")

hist(hpcdata$Global_active_power, col = "red", main = "Global Active Power", xlab = "Global Active Power (kilowatts)")

dev.off()