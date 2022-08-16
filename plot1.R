#RESEARCH QUESTION:
#Have total emissions from PM2.5 decreased in the United States from 1999 to 2008? 
#Using the base plotting system, make a plot showing the total PM2.5 emission from 
#all sources for each of the years 1999, 2002, 2005, and 2008.

### Creates a line graph showing total US Emissions over time

if(!file.exists("summarySCC_PM25.rds")){
        download.file(url="https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip",
              destfile="NEIdata.zip", method="curl")
        unzip("NEIdata.zip")
}
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

emissions <- tapply(NEI$Emissions, NEI$year, sum)
years <- c(1999, 2002, 2005, 2008)


png(filename="plot1.png")

plot(years, emissions/1000000, type="l", lwd=2, main="US Emissions 1999-2008", 
     ylab="emissions (millions of tons)", lab=c(8,10,10))

dev.off()