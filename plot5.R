#RESEARCH QUESTION:
#How have emissions from motor vehicle sources changed from 1999–2008 in Baltimore City?

### Creates four box plots (by year), showing motor vehicle emissions in Baltimore

if(!file.exists("summarySCC_PM25.rds")){
        download.file(url="https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip",
                      destfile="NEIdata.zip", method="curl")
        unzip("NEIdata.zip")
}
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")
Balt <- subset(NEI, fips=="24510")

vehicle_codes <- subset(SCC, grepl("Mobile", EI.Sector))[[1]]
vehicles <- subset(Balt,SCC %in% vehicle_codes)

vehicles99 <- subset(vehicles, year==1999)
vehicles02 <- subset(vehicles, year==2002)
vehicles05 <- subset(vehicles, year==2005)
vehicles08 <- subset(vehicles, year==2008)

png(filename="plot5.png")

par(mfrow=c(1,4), mgp=c(2,1,0), oma=c(5,1,3,1), mar=c(3,4,1,2))

# Log10 transformation note: 0.000001 added to each value to remove log10(0) coercions

boxplot(log10(vehicles99$Emissions+0.000001), xlab="1999", ylim=c(-6,2.5), 
        ylab="log(emissions)")
boxplot(log10(vehicles02$Emissions+0.000001), xlab="2002", ylim=c(-6,2.5))
boxplot(log10(vehicles05$Emissions+0.000001), xlab="2005", ylim=c(-6,2.5))
boxplot(log10(vehicles08$Emissions+0.000001), xlab="2008", ylim=c(-6,2.5))
title(main="Emissions from Motor Vehicles in Baltimore", outer=TRUE, 
      sub="* values below -5.5 are numerically equivalent to 0 emissions")

dev.off()