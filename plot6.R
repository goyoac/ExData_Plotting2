library(ggplot2)

if(!exists("NEI")){
        NEI <- readRDS("summarySCC_PM25.rds")
}
if(!exists("SCC")){
        SCC <- readRDS("Source_Classification_Code.rds")
}

if(!exists("NEISCC")){
        NEISCC <- merge(NEI, SCC, by="SCC")
}

bclaNEI <- subset(NEISCC, fips == "24510"|fips=="06037")

bclaVehiclesNEI <- subset(bclaNEI,grepl("vehicle", bclaNEI$EI.Sector, ignore.case = TRUE))

totalEmissionsPerYear <- aggregate(Emissions ~ year + fips, bclaVehiclesNEI, sum)

png('plot6.png', width=640, height=480)
myPlot <- ggplot(totalEmissionsPerYear, aes(x=year, y=Emissions, colour=fips)) + 
        geom_line() +
        geom_point( size=4, shape=21, fill="white") +
        labs(x="year", y="emissions (Tons)") + 
        labs(colour = "U.S. county") + 
        labs(title=expression("Total PM"[2.5]*" motor vehicle emissions in Baltimore City (24510) vs. Los Angeles (06037)")) +
        scale_x_continuous(breaks=seq(1999,2008,3),minor_breaks=NULL)
print(myPlot)
dev.off()