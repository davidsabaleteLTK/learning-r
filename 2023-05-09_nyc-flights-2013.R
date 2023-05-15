install.packages("nycflights13")
library(dplyr)
library(ggplot2)
library(nycflights13)

data = flights %>% sample_frac(.01)

ggplot(data, aes(x=distance, y=dep_delay)) + 
  geom_point()

ggplot(data, aes(x=distance, y=dep_delay, color=carrier)) + 
  geom_point()

ggplot(data, aes(x=distance, y=dep_delay)) + 
  geom_point(color="blue")

data = flights %>% sample_frac(.005)
ggplot(data, aes(x=distance, y=dep_delay, size=air_time)) + 
  geom_point()
