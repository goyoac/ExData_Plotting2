library(ggplot2)

if(!exists("NEI")){
        NEI <- readRDS("summarySCC_PM25.rds")
}
if(!exists("SCC")){
        SCC <- readRDS("Source_Classification_Code.rds")
}

baltimoreNEI <- subset(NEI, fips == "24510")

totalEmissionsPerYear <- aggregate(Emissions ~ year + type, baltimoreNEI, sum)

png('plot3.png', width=640, height=480)
myPlot <- ggplot(totalEmissionsPerYear, aes(x=year, y=Emissions, colour=type)) + 
          geom_line() +
          geom_point( size=4, shape=21, fill="white") +
          labs(x="year", y=expression("emissions (Tons)")) +
          labs(colour = "source type") +
          labs(title=expression("Total PM"[2.5]*" emissions by type in Baltimore City")) +
          scale_x_continuous(breaks=seq(1999,2008,3),minor_breaks=NULL)
print(myPlot)
dev.off()