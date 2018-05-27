##install.packages("dplyr")

# read the data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

str(NEI)
head(NEI)
str(SCC)
head(SCC)

# Have total emissions from PM2.5 decreased in the United States from 1999 to 2008? 
# Using the base plotting system, make a plot showing the total PM2.5 emission 
# from all sources for each of the years 1999, 2002, 2005, and 2008.

library(dplyr)

grouped <- NEI %>%
              group_by(year) %>%
              summarise(Emissions = sum(Emissions))

str(grouped)

#changing the device
png(filename = "plot1.png")

par(bg="#FFFAF0")
par(mar = c(3,3,3,3))

plot((grouped$Emissions)/10^6 ~ grouped$year, 
     type = "b",
     pch = 18,
     lty = 3,
     lwd = 2,
     col = "magenta",
     xlim = c(1998,2009),
     ylim = c(3,8),
     xlab = "Year",
     ylab = "Total emmissions (in million tons)",
     main = expression('Total PM'[2.5]*' emissions at various years'))

#checking and closing the device
dev.cur()
dev.off()
