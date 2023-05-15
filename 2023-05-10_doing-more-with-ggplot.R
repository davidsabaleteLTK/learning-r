# Doing more with ggplot

## Using smooth functions
library(ggplot2)
library(palmerpenguins)
ggplot(data=penguins, aes(x=flipper_length_mm, y=body_mass_g)) + 
  geom_smooth() + 
  geom_point()

ggplot(data=penguins, aes(x=flipper_length_mm, y=body_mass_g)) + 
  geom_point() +
  geom_smooth(se=FALSE)

ggplot(data=penguins, aes(x=flipper_length_mm, y=body_mass_g, linetype=species)) + 
  geom_smooth()

# geom_jitter
ggplot(data=penguins, aes(x=flipper_length_mm, y=body_mass_g)) + 
  geom_jitter()

# geom_bar
ggplot(data=diamonds) + 
  geom_bar(mapping=aes(x=cut, color=cut))

ggplot(data=diamonds) + 
  geom_bar(mapping=aes(x=cut, fill=cut))

ggplot(data=diamonds) + 
  geom_bar(mapping=aes(x=cut, fill=clarity))

# Facets

## facet_wrap
ggplot(data=penguins, aes(x=flipper_length_mm, y=body_mass_g, color=species)) + 
  geom_point() +
  facet_wrap(~species)

ggplot(data=diamonds, mapping=aes(x=color, fill=cut)) + 
  geom_bar() + 
  facet_wrap(~cut)

## facet_grid
ggplot(data=penguins, aes(x=flipper_length_mm, y=body_mass_g, color=species)) + 
  geom_point() +
  facet_grid(sex~species)

ggplot(data=penguins, aes(x=flipper_length_mm, y=body_mass_g, color=species)) + 
  geom_point() +
  facet_grid(~sex)

