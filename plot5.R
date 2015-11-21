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

baltimoreNEI <- subset(NEISCC, fips == "24510")

baltimoreVehiclesNEI <- subset(baltimoreNEI,grepl("vehicle", baltimoreNEI$EI.Sector,ignore.case = TRUE))

totalEmissionsPerYear <- aggregate(Emissions ~ year, baltimoreVehiclesNEI, sum)

png('plot5.png', width=480, height=480)
myPlot <- ggplot(totalEmissionsPerYear, aes(x=year, y=Emissions)) + 
        geom_bar(stat="identity",fill="royalblue2",width=2) +
        labs(x="year", y="emissions (Tons)") + 
        labs(title=expression("Total PM"[2.5]*" motor vehicle emissions in Baltimore City")) +
        scale_x_continuous(breaks=seq(1999,2008,3),minor_breaks=NULL)
print(myPlot)
dev.off()