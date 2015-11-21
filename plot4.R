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

emissionsFromCoalCombustionRelatedSourcesNEI <- subset(NEISCC,grepl('Coal',NEISCC$Short.Name, fixed=TRUE))

emissionsFromCoalCombustionRelatedSourcesNEI$Emissions <- emissionsFromCoalCombustionRelatedSourcesNEI$Emissions/10^3

totalEmissionsPerYear <- aggregate(Emissions ~ year + type, emissionsFromCoalCombustionRelatedSourcesNEI, sum)

png('plot4.png', width=480, height=480)
myPlot <- ggplot(totalEmissionsPerYear, aes(x=year, y=Emissions, fill = type)) +
        geom_bar(stat= "identity", width = 2) + 
        labs(x="year", y=expression("emissions (x 10^3 Tons)")) + 
        labs(fill="source type") + 
        labs(title=expression("Total PM"[2.5]*" coal combustion related emissions in US")) +
        scale_x_continuous(breaks=seq(1999,2008,3),minor_breaks=NULL)
print(myPlot)
dev.off()