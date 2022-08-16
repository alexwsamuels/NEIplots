#RESEARCH QUESTION:
#Across the United States, how have emissions from coal combustion-related sources 
#changed from 1999–2008?

### Creates four box plots (by year), showing coal emissions in the US

if(!file.exists("summarySCC_PM25.rds")){
        download.file(url="https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip",
                      destfile="NEIdata.zip", method="curl")
        unzip("NEIdata.zip")
}
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

coal_codes <- subset(SCC, grepl("Coal", EI.Sector))[[1]]
coal <- subset(NEI,SCC %in% coal_codes)

coal99 <- subset(coal, year==1999)
coal02 <- subset(coal, year==2002)
coal05 <- subset(coal, year==2005)
coal08 <- subset(coal, year==2008)

png(filename="plot4.png")

par(mfrow=c(1,4), mgp=c(2,1,0), oma=c(5,1,3,1), mar=c(3,4,1,2))

# Log10 transformation note: 0.00001 added to each value to remove log10(0) coercions

boxplot(log10(coal99$Emissions+0.00001), xlab="1999", ylab="log(emissions)")
boxplot(log10(coal02$Emissions+0.00001), xlab="2002")
boxplot(log10(coal05$Emissions+0.00001), xlab="2005")
boxplot(log10(coal08$Emissions+0.00001), xlab="2008")
title(main="Emissions from Coal-Based Sources", outer=TRUE, 
      sub="* values below -4 are numerically equivalent to 0 emissions")

dev.off()