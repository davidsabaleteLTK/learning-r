library(ggplot2)
library(palmerpenguins)
library(tidyr)
library(tidyverse)

penguins %>% 
  drop_na(sex) %>% 
  ggplot(aes(x=flipper_length_mm, y=body_mass_g)) +
  geom_point(aes(color=species, shape=species)) +
  facet_wrap(~sex)


glimpse(penguins)

