if(!exists("NEI")){
        NEI <- readRDS("summarySCC_PM25.rds")
}
if(!exists("SCC")){
        SCC <- readRDS("Source_Classification_Code.rds")
}

baltimoreNEI <- subset(NEI, fips == "24510")

totalEmissionsPerYear <- aggregate(Emissions ~ year, baltimoreNEI, sum)

png('plot2.png')
barplot(height=totalEmissionsPerYear$Emissions, 
        col = "royalblue2",
        names.arg=totalEmissionsPerYear$year, 
        xlab="year", 
        ylab="emissions (Tons)",
        main=expression('Total PM'[2.5]*' emissions per year in Baltimore City'))
dev.off()