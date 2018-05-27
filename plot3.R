##install.packages("dplyr")

# read the data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

str(NEI)
head(NEI)
str(SCC)
head(SCC)

## Of the four types of sources indicated by the type (point, nonpoint, onroad, nonroad) variable, 
## which of these four sources have seen decreases in emissions from 1999???2008 for Baltimore City? 
## Which have seen increases in emissions from 1999???2008? Use the ggplot2 plotting system to make 
## a plot answer this question.

library(dplyr)

grouped <- NEI %>%
  filter(fips == "24510") %>%
  group_by(type, year) %>%
  summarise(Emissions = sum(Emissions))

library(ggplot2)
#changing the device
png(filename = "plot3.png")

par(bg="#FFFAF0")

ggplot(data = grouped, aes(x=year, y=Emissions, colour=type)) +
  geom_line() +
  ggtitle(expression('Total PM'[2.5]*' emissions at various years by type in Baltimore')) +
  labs(x = "Year", y = "Total emmissions (in tons)", colour = "Type") +
  theme(plot.margin = unit(c(1,1,1,1), "cm"))

#checking and closing the device
dev.cur()
dev.off()