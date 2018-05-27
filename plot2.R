##install.packages("dplyr")

# read the data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

str(NEI)
head(NEI)
str(SCC)
head(SCC)

## Have total emissions from PM2.5 decreased in the Baltimore City, 
## Maryland (fips=="24510") from 1999 to 2008? 
## Use the base plotting system to make a plot answering this question.

library(dplyr)

grouped <- NEI %>%
  filter(fips == "24510") %>%
  group_by(year) %>%
  summarise(Emissions = sum(Emissions))

str(grouped)

#changing the device
png(filename = "plot2.png")

par(bg="#FFFAF0")
par(mar = c(3,3,3,3))

plot((grouped$Emissions)/10^2 ~ grouped$year, 
     type = "b",
     pch = 18,
     lty = 3,
     lwd = 2,
     col = "magenta",
     xlim = c(1998,2009),
     ylim = c(15,35),
     xlab = "Year",
     ylab = "Total emmissions (in hundred tons)",
     main = expression('Total PM'[2.5]*' emissions at various years in Baltimore'))

#checking and closing the device
dev.cur()
dev.off()