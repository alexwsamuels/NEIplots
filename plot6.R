#RESEARCH QUESTION:
#Compare emissions from motor vehicle sources in Baltimore City with emissions from 
#motor vehicle sources in Los Angeles County, California (fips == "06037"). Which 
#city has seen greater changes over time in motor vehicle emissions?

### Creates a line graph with two lines, one each for Baltimore and LA, showing
### aggregate motor vehicle emissions over time

if(!file.exists("summarySCC_PM25.rds")){
        download.file(url="https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip",
                      destfile="NEIdata.zip", method="curl")
        unzip("NEIdata.zip")
}
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")
Balt <- subset(NEI, fips=="24510")
LosA <- subset(NEI, fips=="06037")

vehicle_codes <- subset(SCC, grepl("Mobile", EI.Sector))[[1]]
BMvehicles <- subset(Balt,SCC %in% vehicle_codes)
LAvehicles <- subset(LosA,SCC %in% vehicle_codes)

BMemissions <- tapply(BMvehicles$Emissions, BMvehicles$year, sum)
LAemissions <- tapply(LAvehicles$Emissions, LAvehicles$year, sum)

years <- c(1999, 2002, 2005, 2008)

png(filename="plot6.png")

#note: line types additionally specified in case reader is colorblind
#log10 transformation allows small changes to be seen on both graphs

plot(years, log10(BMemissions), type="l", lwd=2, main="Motor Vehicle Emissions 1999-2008 by City",
     ylab="log(emissions)", ylim=c(2.5,4.5), lab=c(8,10,5))
lines(years, log10(LAemissions), type="l", lty=2, lwd=2, col="gold")
legend("topright", legend=c("Baltimore", "Los Angeles"), lty=c(1,2), lwd=2, 
       col=c("black", "gold"))

dev.off()