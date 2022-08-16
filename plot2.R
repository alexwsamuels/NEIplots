#RESEARCH QUESTION:
#Have total emissions from PM2.5 decreased in the Baltimore City, Maryland 
#(fips == "24510") from 1999 to 2008? Use the base plotting system to make a plot 
#answering this question.

### Creates  a line graph showing Baltimore City emissions over time

if(!file.exists("summarySCC_PM25.rds")){
        download.file(url="https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip",
                      destfile="NEIdata.zip", method="curl")
        unzip("NEIdata.zip")
}
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")
Balt <- subset(NEI, fips=="24510")

emissions <- tapply(Balt$Emissions, Balt$year, sum)
years <- c(1999, 2002, 2005, 2008)


png(filename="plot2.png")

plot(years, emissions, type="l", lwd=2, main="Baltimore Emissions 1999-2008", 
     lab=c(8,10,10))

dev.off()