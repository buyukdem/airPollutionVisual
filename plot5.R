##install.packages("dplyr")
##install.packages("stringr")

# read the data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

str(NEI)
head(NEI)
str(SCC)
head(SCC)

## How have emissions from motor vehicle sources changed from 1999???2008 in Baltimore City?

library(stringr)
library(dplyr)
motor_dat <- SCC %>%
  filter(str_detect(str_to_lower(SCC.Level.Three), "motor"))
str(motor_dat)

merged_data <- NEI %>% inner_join(motor_dat) %>%
                filter(fips == "24510")

merged_data_grouped <- merged_data %>% 
  group_by(year) %>%
  summarise(Emissions = sum(Emissions))


#changing the device
library(ggplot2)
png(filename = "plot5.png")

par(bg="#FFFAF0")

ggplot(data = merged_data_grouped, aes(x=year, y=Emissions)) +
  geom_line(linetype = 2, colour = "#0072B2") +
  geom_point(shape = 19, colour = "#0075B2") +
  ggtitle("Total PM2.5 emissions emissions from \nmotor vehicle sources at various years in Baltimore City") +
  labs(x = "Year", y = "Total emmissions (in tons)") +
  theme(plot.margin = unit(c(1,1,1,1), "cm"))

#checking and closing the device
dev.cur()
dev.off()