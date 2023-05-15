install.packages("tidyverse")
library(tidyverse)
library(ggplot2)

head(diamonds)

ggplot(data=diamonds) +
  geom_bar(mapping=aes(x=color, fill=cut)) +
  facet_wrap(~clarity)
