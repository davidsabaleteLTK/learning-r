install.packages("palmerpenguins")
library(palmerpenguins)
library(ggplot2)
data("penguins")
View(penguins)

# ggplot(data = penguins) + geom_point(mapping = aes(x = flipper_length_mm, y = body_mass_g))

ggplot(data = penguins, mapping = aes(x = flipper_length_mm, y = body_mass_g, color = species)) +  geom_point()

?geom_point
?geom_bar
