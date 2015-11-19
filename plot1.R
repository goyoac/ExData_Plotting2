if(!exists("NEI")){
        NEI <- readRDS("summarySCC_PM25.rds")
}
if(!exists("SCC")){
        SCC <- readRDS("Source_Classification_Code.rds")
}

if(!exists("totalEmissionsPerYear")){
        totalEmissionsPerYear <- aggregate(Emissions ~ year, NEI, sum)
}

png('plot1.png')
barplot(height=totalEmissionsPerYear$Emissions/10^6, 
        col = "darkred",
        names.arg=totalEmissionsPerYear$year, 
        xlab="three-years periods", 
        ylab="emissions (x 10^6 Tons)",
        main=expression('Total PM'[2.5]*' emissions for periods of three years in the US'))
dev.off()