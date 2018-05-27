##install.packages("dplyr")
##install.packages("stringr")

# read the data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

str(NEI)
head(NEI)
str(SCC)
head(SCC)

## Across the United States, how have emissions from coal combustion-related sources changed from 1999???2008?

library(stringr)
library(dplyr)
coal_dat <- SCC %>%
            filter(str_detect(str_to_lower(EI.Sector), "coal"))
str(coal_dat)

merged_data <- NEI %>% inner_join(coal_dat)

merged_data_grouped <- merged_data %>% 
                       group_by(year) %>%
                       summarise(Emissions = sum(Emissions))

#changing the device
library(ggplot2)
png(filename = "plot4.png")

par(bg="#FFFAF0")

ggplot(data = merged_data_grouped, aes(x=year, y=Emissions/10^4)) +
  geom_line(linetype = 2, colour = "#0072B2") +
  geom_point(shape = 19, colour = "#0075B2") +
  ggtitle("Total PM2.5 emissions from coal combustion-related \nsources at various years") +
  labs(x = "Year", y = "Total emmissions (in ten thousand tons)") +
  theme(plot.margin = unit(c(1,1,1,1), "cm"))

#checking and closing the device
dev.cur()
dev.off()