library(tidyverse)

dat <- read.csv("FAOSTAT_data_9-26-2020_2.csv", header = TRUE)
#dat <- read.csv("FAOSTAT_data_9-26-2020.csv", header = TRUE, fileEncoding="UTF-8")

dat2 <- dat %>%
  select(-Flag) %>%
  drop_na() %>% 
  rename(val = Value) %>% 
  arrange(desc(val))

table_df<-data.frame(Country=dat2$Area, Value=dat2$val)

library(rworldmap)
mapDevice('x11')
sdat <- joinCountryData2Map(dat2, joinCode="NAME", nameJoinColumn="Area")
par(family="JP4")
mapCountryData(sdat, nameColumnToPlot="val", catMethod="fixedWidth", mapTitle = "Eggplant production [ton](2018)", addLegend = TRUE)

library(kabel)
library(kableExtra)
library(clipr)
kable(table_df, align = "c") %>%
  kable_styling(full_width = F) %>%
  column_spec(1, bold = T) %>%
  collapse_rows(columns = 1, valign = "middle") %>%
  write_clip

