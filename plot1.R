setwd("C:/Users/Vini/Documents/R")

library(dplyr)
library(tidyr)
library(data.table)

if (!file.exists("EDA_Assign1")) {
        dir.create("EDA_Assign1")
}


## DOWNLOAD AND UNZIP DATA
addr <- "http://archive.ics.uci.edu/ml/machine-learning-databases/00235/household_power_consumption.zip"
download.file(addr, destfile = "./EDA_Assign1/data.zip", mode ="wb")
unzip("./EDA_Assign1/data.zip", exdir = "./EDA_Assign1")
#dateDownloaded <- date()


## PREPARING THE DATA
## read data and convert to dplyr data frames
file <- "./EDA_Assign1/household_power_consumption.txt"
f <- tbl_df(fread(file, na.strings="?",stringsAsFactors=FALSE, nrows = 0 ))
df <- tbl_df(fread(file, na.strings="?",stringsAsFactors=FALSE, skip = 66500, nrows = 3500 ))
names(df) <- names(f)
## finding the start and end of the data that interests
s  <- grep("1/2/2007", df$Date, value = FALSE)
e  <- grep("3/2/2007", df$Date, value = FALSE)
st <- s[1]
ed <- e[1]-1
## subsetting to the desired data 
d <- df[st:ed,]
## formatting date and time
d$dtime <- paste(d$Date, d$Time)
d$dtime <- as.POSIXct(d$dtime, format = "%d/%m/%Y %H:%M:%S")


##  PLOTTING THE DATA
png(filename = "plot1.png")
hist(d$Global_active_power, col="red", main = "Global Active Power", xlab = "Global Active Power (kilowatts)")
dev.off()
