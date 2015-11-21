if(!exists("NEI")){
        NEI <- readRDS("summarySCC_PM25.rds")
}
if(!exists("SCC")){
        SCC <- readRDS("Source_Classification_Code.rds")
}

totalEmissionsPerYear <- aggregate(Emissions ~ year, NEI, sum)

png('plot1.png')
barplot(height=totalEmissionsPerYear$Emissions/10^3, 
        col = "royalblue2",
        names.arg=totalEmissionsPerYear$year, 
        xlab="year", 
        ylab="emissions (x 10^3 Tons)",
        main=expression('Total PM'[2.5]*' emissions per year in the US'))
dev.off()