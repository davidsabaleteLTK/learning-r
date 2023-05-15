install.packages("dplyr")
library(dplyr)
library(ggplot2)

#download.file("http://datacarpentry.github.io/dc_zurich/data/portal_data_joined.csv","data/portal_data_joined.csv")

surveys_complete <- read.csv(file = "data/portal_data_joined.csv")

ggplot(surveys_complete, aes(x = weight, y = hindfoot_length)) +
  geom_point()

# We can reduce over-plotting by adding some jitter:
ggplot(surveys_complete, aes(x = weight, y = hindfoot_length)) +
  geom_point(position = position_jitter())

# We can add additional aesthetic values according to other properties from our dataset. For instance, if we want to color points differently depending on the species.
ggplot(surveys_complete, aes(x = weight, y = hindfoot_length, colour = species_id)) +
  geom_point(position = position_jitter())

# We can make the points more transparent so we can assess the overplotting.
ggplot(surveys_complete, aes(x = weight, y = hindfoot_length, colour = species_id)) +
  geom_point(alpha = 0.3,  position = position_jitter())

# Just like we did for the species_id and the colors, we can do the same with using different shapes for
ggplot(surveys_complete, aes(x = weight, y = hindfoot_length, colour = species_id, shape = as.factor(plot_id))) +
  geom_point(alpha = 0.3,  position = position_jitter())

# ggplot2 also allows you to calculate directly some statistical
ggplot(surveys_complete, aes(x = weight, y = hindfoot_length, colour = species_id)) +
  geom_point(alpha = 0.3,  position = position_jitter()) + 
  stat_smooth(method = "lm")

surveys_complete %>%
  filter(species_id == "DS") %>%
  ggplot(aes(x = weight, y = hindfoot_length, colour = species_id)) +
  geom_point(alpha = 0.3,  position = position_jitter()) + stat_smooth(method = "lm")

ggplot(subset(surveys_complete, species_id == "DS"), 
       aes(x = weight, y = hindfoot_length, colour = species_id)) +
  geom_point(alpha = 0.3,  position = position_jitter()) + stat_smooth(method = "lm") +
  ylim(c(0, 60))

# Using ylim subsets the data to be represented:
ggplot(surveys_complete,
       aes(x = weight, y = hindfoot_length, colour = species_id)) +
  geom_point(alpha = 0.3,  position = position_jitter()) + stat_smooth(method = "lm") +
  ylim(c(40, 60))

# while setting limits with coord_cartesian acts a magnifying glass:
ggplot(surveys_complete,
       aes(x = weight, y = hindfoot_length, colour = species_id)) +
  geom_point(alpha = 0.3,  position = position_jitter()) + stat_smooth(method = "lm") +
  coord_cartesian(ylim = c(40, 60))

# Boxplot
# Visualising the distribution of weight within each species.
ggplot(subset(surveys_complete, !is.na(weight)), aes(x = species_id, y = weight)) +
  geom_boxplot()

# By adding points to boxplot, we can see particular measurements and the abundance of measurements.
ggplot(subset(surveys_complete, !is.na(weight)), aes(x = species_id, y = weight)) +
  geom_point(alpha=0.3, color="tomato", position = "jitter") +
  geom_boxplot(alpha=0) + coord_flip()

head(surveys_complete)

colnames(surveys_complete)

## Challenge
# - Create boxplot for hindfoot_length, and change the color of the points.
# - Replace the boxplot by a violin plot
# - Add the layer coord_flip()
ggplot(subset(surveys_complete, !is.na(weight)), aes(x = species_id, y = hindfoot_length)) +
  geom_point(color="purple", position = "jitter") +
  geom_boxplot(alpha=0.5)

ggplot(subset(surveys_complete, !is.na(weight)), aes(x = species_id, y = hindfoot_length)) +
  geom_point(color="purple", position = "jitter") +
  geom_violin(alpha=0.5) + coord_flip()


# Faceting
ggplot(subset(surveys_complete, !is.na(weight)), aes(species_id, weight)) +
  geom_point(alpha=0.3, color="tomato", position = "jitter") +
  geom_boxplot(alpha=0) + coord_flip() + facet_wrap( ~ sex)

## Challenge
# - Modify the data frame so we only look at males and females
# - Change the colors, so points for males and females are different
# - Change the data frame to only plot three species of your choosing
ggplot(subset(surveys_complete, species_id %in% c("DO", "DM", "DS") & sex %in% c("F", "M")),
       aes(x = sex, y = weight,  colour = interaction(sex, species_id))) + facet_wrap( ~ species_id) +
  geom_point(alpha = 0.3, position = "jitter") +
  geom_boxplot(alpha = 0, colour = "black")

# Barplot
ggplot(surveys_complete, aes(species_id)) + geom_bar()

surveys_complete %>%
  filter(!is.na(weight)) %>%
  group_by(species_id) %>%
  summarize(mean_weight = mean(weight)) %>%
  ggplot(aes(x = species_id, y = mean_weight)) + geom_bar(stat = "identity")


## Challenge
# - Repeat the same thing on the hindfoot length instead of the weight
surveys_complete %>%
  filter(!is.na(hindfoot_length)) %>%
  group_by(species_id) %>%
  summarize(mean_hindfoot = mean(hindfoot_length)) %>%
  ggplot(aes(x = species_id, y = mean_hindfoot)) + geom_bar(stat = "identity")


# Plotting time series data
# Let’s calculate number of counts per year for each species. To do that we need to group data first and count records within each group.
yearly_counts <- surveys_complete %>%
  group_by(year, species_id) %>%
  summarise(count=n())

# Timelapse data can be visualised as a line plot with years on x axis and counts on y axis.
ggplot(yearly_counts, aes(x=year, y=count)) +
  geom_bar(stat = "identity")

# This is the plot data for all the species together. We need to tell ggplot to split graphed data by species_id
ggplot(yearly_counts, aes(x=year, y=count, group=species_id)) +
  geom_line()

# We will be able to distiguish species in the plot if we add colors.
ggplot(yearly_counts, aes(x=year, y=count, group=species_id, color=species_id)) +
  geom_line()

## Challenge
# - Draw the yearly counts for the species DO, DS, DM
# - Draw the yearly counts for each plot type
# - Draw the yearly counts for all taxa but Rodents
# - Draw the yearly counts for species that have been captured more than 2000 times over the course of the surveys (difficult)
# - Draw the yearly counts for the species that have been captured at least 300 times in one year (difficult)
surveys_complete %>%
  group_by(taxa, year) %>%
  tally %>%
  filter(taxa != "Rodent") %>%
  ggplot(aes(x = year, y = n, group = taxa, color = taxa)) +
  geom_line()

surveys_complete %>%
  group_by(plot_type, year) %>%
  tally %>%
  ggplot(aes(x = year, y = n, group = plot_type, color = plot_type)) +
  geom_line()

### Easy
yearly_counts %>%
  filter(species_id %in% c("DO", "DS", "DM")) %>%
  ggplot(aes(x = year, y = count, group = species_id, color = species_id)) +
  geom_line()

### Difficult
sp_totals <- surveys_complete %>%
  group_by(species_id) %>%
  summarise(count = n()) %>%
  filter(count > 2000) %>%
  .$species_id

yearly_counts %>%
  filter(species_id %in% sp_totals) %>%
  ggplot(aes(x = year, y = count, group = species_id, color = species_id)) +
  geom_line()

### More difficult
sp_250 <- yearly_counts %>%
  filter(count >=  300) %>%
  ungroup %>%
  select(species_id) %>%
  unique

yearly_counts %>%
  filter(species_id %in% sp_250$species_id) %>%
  ggplot(aes(x = year, y = count, group = species_id, color = species_id)) +
  geom_line()


## Resources for going further
# - The ggplot2 documentation: http://docs.ggplot2.org/
# - The R cookbook website: http://www.cookbook-r.com/
# - Customizing the aspect of your plots with themes: http://docs.ggplot2.org/dev/vignettes/themes.html