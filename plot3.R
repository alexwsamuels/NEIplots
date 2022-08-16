#RESEARCH QUESTION:
#Of the four types of sources indicated by the "type" (point, nonpoint, onroad, 
#nonroad) variable, which of these four sources have seen decreases in emissions 
#from 1999–2008 for Baltimore City? Which have seen increases in emissions from 
#1999–2008? Use the ggplot2 plotting system to make a plot answer this question.

### Creates a line graph with four lines, one for each type of emission, showing
### Baltimore City emissions over time

if(!file.exists("summarySCC_PM25.rds")){
        download.file(url="https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip",
                      destfile="NEIdata.zip", method="curl")
        unzip("NEIdata.zip")
}
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")
Balt <- subset(NEI, fips=="24510")

subpt <- subset(Balt, type=="POINT")
subnp <- subset(Balt, type=="NONPOINT")
subor <- subset(Balt, type=="ON-ROAD")
subnr <- subset(Balt, type=="NON-ROAD")

point <- tapply(subpt$Emissions, subpt$year, sum)
nonpoint <- tapply(subnp$Emissions, subnp$year, sum)
on.road <- tapply(subor$Emissions, subor$year, sum)
non.road <- tapply(subnr$Emissions, subnr$year, sum)

years <- c(1999, 2002, 2005, 2008)

png(filename="plot3.png")

#note: line types additionally specified in case reader is colorblind

plot(years, point, type="l", lwd=2, main="Baltimore Emissions 1999-2008 by Type",
     ylab="emissions (tons)", ylim=c(0,2200), lab=c(8,10,5))
lines(years, nonpoint, type="l", lty=2, lwd=2, col="red")
lines(years, on.road, type="l", lty=3, lwd=2, col="blue")
lines(years, non.road, type="l", lty=4, lwd=2, col="gold")
legend("topright", legend=c("point", "nonpoint", "on-road", "non-road"), 
       lty=c(1,2,3,4), lwd=2, col=c("black", "red", "blue", "gold"))

dev.off()