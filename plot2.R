## Load libraries
library(dplyr)

## Check files are present in the Directory
files<-dir()
ifelse (("summarySCC_PM25.rds" %in% files & "Source_Classification_Code.rds" %in% files),
        print("Files are present, proceeding with Plot"),
        stop("Please place the summarySCC_PM25.rds and Source_Classification_Code.rds, 
             in the same folder as this script and re-run."))

## Read the two files
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

## Tidy the data frames
NEI<-tbl_df(NEI)

NEI_grp<-NEI %>%
  filter(fips == "24510") %>%
  group_by(year) %>%
  mutate(sum_emissions=sum(Emissions,na.rm=T)) %>%
  select(year,sum_emissions) %>% 
  unique()

## Plot the graph
png("plot2.png")
plot(NEI_grp$year,NEI_grp$sum_emissions/1000,col="red",
     las=1, type='o', col.axis = "dodgerblue", col.lab = "firebrick",
     xlab="Year",ylab="Total Emissions(kilo ton-10^3)",
     main="Total emissions for Baltimore City, Maryland")
grid()
dev.off()
