##install.packages("dplyr")
##install.packages("stringr")

# read the data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

str(NEI)
head(NEI)
str(SCC)
head(SCC)

## Compare emissions from motor vehicle sources in Baltimore City 
## with emissions from motor vehicle sources in Los Angeles County, 
## California (fips == "06037"). Which city has seen greater changes over time in motor vehicle emissions?

library(stringr)
library(dplyr)
motor_dat <- SCC %>%
  filter(str_detect(str_to_lower(SCC.Level.Three), "motor"))
str(motor_dat)

merged_data <- NEI %>% inner_join(motor_dat) %>%
  filter(fips == "24510" | fips == "06037")

merged_data_grouped <- merged_data %>% 
  group_by(fips, year) %>%
  summarise(Emissions = sum(Emissions))

#changing the device
library(ggplot2)
library(grid)
png(filename = "plot6.png")

ggplot(data = merged_data_grouped, aes(x=year, y=Emissions, colour = fips)) +
  geom_line(linetype = 2) +
  geom_text(aes(x = 2003, y = 65, label = "Los Angeles County")) + 
  geom_text(aes(x = 2003, y = 20, label = "Baltimore City")) +
  geom_point(shape = 19) +
  ggtitle("Total PM2.5 emissions from motor vehicle sources \nat various years in Baltimore City compared to Los Angeles County") +
  labs(x = "Year", y = "Total emmissions (in tons)") +
  theme(plot.margin = unit(c(1,1,1,1), "cm"))

#checking and closing the device
dev.cur()
dev.off()