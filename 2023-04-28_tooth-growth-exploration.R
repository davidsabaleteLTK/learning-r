data("ToothGrowth")
head(ToothGrowth)
install.packages("dplyr")

# atomic
filtered_tg <- filter(ToothGrowth, dose == 0.5)
View(filtered_tg)
arrange(filtered_tg,len)

# nested
arrange(filter(ToothGrowth, dose == 0.5),len)

# using pipes
filtered_toothgrowth <- ToothGrowth %>% 
  filter(dose==0.5) %>% 
  arrange(len)

# more complex example using average
filtered_toothgrowth <- ToothGrowth %>% 
  filter(dose==0.5) %>% 
  group_by(supp) %>% 
  summarise(mean_lean = mean(len,na.rm = T),.group="drop")

library(lubridate)
mdy("April 10, 2019")
