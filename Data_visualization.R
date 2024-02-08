## REFERENCE MATERIAL: R FOR DATA SCIENCE
## ABUJA R USERS GROUP

#=========CHAPTER 1 & 2 PRACTICAL===========================
# Importation of the "tidyverse" package
# Shortcut for " <- " is alt + -

library(tidyverse)

#Installation of the "palmerpenguins" package which contains the DATASET
library(palmerpenguins)
library(ggthemes) #for colorblind pellette
penguins
str(penguins)
sum(is.na(penguins))   #To know the total missing values NA

#Romove NA from the dataset of penguins
penguins <- na.omit(penguins)
attach(penguins)
View(penguins)
str(penguins)  #to view the structure of the data
# Objective: To visualize the penguins data as displayed in the textbook

penguins %>% ggplot() + aes(flipper_length_mm, body_mass_g) +
  geom_point(aes(color=species, shape = species)) + 
  geom_smooth(method = 'lm') +
  labs(
    title = "Body mass and flipper length",
    subtitle = "Dimensions for Adelie, Chinstrap, and Gentoo Penguins",
    x = "Flipper length (mm)", y = "Body mass (g)",
    color = "Species", shape = "Species"
  ) +
  scale_color_colorblind()
ggsave(filename = 'R-USERS_BODY_MASS_FLIPPER_LENGTH.PNG')

#Exercise
penguins #1 344 row and 8 columns

?penguins #2 a number denoting bill depth (millimeters)

#3 No relationship between bill_length and bill_depth_mm
penguins %>% ggplot() + aes(bill_length_mm, bill_depth_mm)+
  geom_point()

#4 geom_boxplot
penguins %>% ggplot()+aes(species,bill_length_mm)+
  geom_boxplot()

#5 No x and y axes given via aes()
penguins %>% ggplot()+geom_point()


#Another method of using %>%  is |> as seen below:

penguins |> ggplot() + aes(flipper_length_mm, body_mass_g) +
  geom_point(aes(color = species, shape = species)) +
  geom_smooth(method = 'lm')

#Visualization of DISTRIBUTION
# Bar Chart
penguins |> ggplot() + aes(species) + geom_bar(aes(color=species)) + 
  labs(title = 'Bar Chart Showing Distributions of Species', x= 'Name of species', y='Frequency')

# Histogram plot
penguins |> ggplot() + aes(body_mass_g)+geom_histogram(binwidth = 500)+
  labs(title = 'Histogram of Body Mass', x='Body Weight', y='Frequency')
#Density plot
penguins %>% ggplot() + aes(body_mass_g)+geom_density()

#EXERCISE 2
penguins |> ggplot()+aes(species)+geom_bar(color='red')

#Or With filled color
penguins %>% ggplot()+aes(species)+geom_bar(fill='blue')

#PLAYING WITH HISTOGRAM
diamonds |> ggplot() + aes(carat) + 
  geom_histogram(binwidth = 0.2, fill='red')

#Boxplot
penguins |> ggplot() +aes(species, body_mass_g)+
  geom_boxplot() +
  labs(title = 'A Boxplot Showing the Distribution of Species')
#Density
penguins %>% ggplot() +aes(x=body_mass_g, color=species, fill=species)+
  geom_density(linewidth = 0.75)

#ggplot(penguins, aes(x = body_mass_g, color = species, fill=species)) +geom_density(linewidth = 0.75)

#PLOT OF TWO CATEGORICAL VARIABLES
penguins |> ggplot() +aes(island, fill= species)+
  geom_bar()
#Or 
penguins %>% ggplot() +aes(species, fill=island)+
  geom_bar()

penguins %>% ggplot() +aes(species, fill=island)+
  geom_bar(position = 'fill')

#EXERCISE  page 29
?mpg
mpg

# Date 08-11-2023 the magrit
#Adding three or more variables

penguins |> ggplot()+
  aes(x = flipper_length_mm, y = body_mass_g) +
  geom_point(aes(color = species, shape = island))

#However, the above can be spit into more useful using FACET
# facet_wrap(~categorica variable) is the code.
penguins |> ggplot()+
  aes(x = flipper_length_mm, y = body_mass_g) +
  geom_point(aes(color = species, shape = species))+
  facet_wrap(~island)+
  labs(
    title = "A facet scatter plot of flipper length(mm) against body mass (g)",
    subtitle = "Distributed across an Island",
    x = "Flipper Length (mm)",
    y = "Body Mass (g)"
  )

# Exercise (page 29)
#1
View(mpg)
?mpg
# From the above, the CATEGORICAL VARIABLES ARE
# manufacturer, model, trans, drv, fl and class#
# While the NUMERICAL VARIABLES ARE:
# displ, year, cyl, cty, hwy
mpg |> ggplot()+
  aes(x=hwy, y=displ)+
  geom_point(aes(color = cty, shape = drv))+
  geom_smooth(method = 'lm')

mpg |> ggplot()+
  aes(hwy, color=displ)+
  geom_density()

ggplot(
  data = penguins,
  mapping = aes(
    x = bill_length_mm, y = bill_depth_mm,
    color = species
  )
) +
  geom_point() +
  labs(color = "Species") +
  facet_wrap(~species) +
  geom_smooth(method = 'lm')

#STACKED BAR CHART
ggplot(penguins, aes(x = island, fill = species)) +
  geom_bar(position = "fill")

ggplot(penguins, aes(x = species, fill = island)) +
  geom_bar(position = "fill")

# ggsave is used in saving graphs outside R
penguins |> ggplot()+
  aes(x = flipper_length_mm, y = body_mass_g)+
  geom_point()+
  geom_smooth(method = 'lm')
ggsave(filename = 'R-user-Penguins_1.png')

#Exercise : The second graph would be saved
ggplot(mpg, aes(x = class)) +
  geom_bar()
ggplot(mpg, aes(x = cty, y = hwy)) +
  geom_point()
ggsave("mpg-plot.png")

?ggsave
#Which of the plots below would be saved
my_bar_plot <- ggplot(mpg, aes(x = class)) +
  geom_bar()
my_scatter_plot <- ggplot(mpg, aes(x = cty, y = hwy)) +
  geom_point()
ggsave(filename = "mpg-plot2.png", plot = my_scatter_plot)


#To see all shortcuts us 'Alt+shift+K

#==========THE END OF CHAPTER ONE AND TWO=================

