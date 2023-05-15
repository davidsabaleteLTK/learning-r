### Libraries for data cleaning

install.packages("here")
library("here")
install.packages("skimr")
library("skimr")
install.packages("janitor")
library("janitor")
install.packages("dplyr")
library("dplyr")


### Load some data

install.packages("palmerpenguins")
library("palmerpenguins")
skim_without_charts(penguins)
glimpse(penguins)
head(penguins)

# Show every column but species
penguins %>% 
  select(-species)

# Renaming columns
penguins %>% 
  rename(island_new=island)

# Apply function to column names
rename_with(penguins,tolower)

# column names are unique and consist only of the _ character, numbers, and letters
clean_names(penguins)


