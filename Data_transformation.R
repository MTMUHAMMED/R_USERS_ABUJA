# CHAPTER THREE: DATA TRANSFORMATIONS
# Packages: tidyverse (dplyr) and nycflights13
library(tidyverse)
#install.packages("nycflights13")   
library(nycflights13)
nycflights13::flights
View(flights)

#Glimpse is used in showing the data structure also
glimpse(flights)

# Flights that departed in January or February (| means OR)
flights |>
  filter(month == 1 | month == 2)
#The above can be written as:
flights |> 
  filter(month %in% c(1,2))

#All the filtering are dataset. They can be save as a new dataset
jan1 <- flights |>
  filter(month == 1 & day == 1)
View(jan1)
glimpse(jan1)   # it gives 842 by 19

# arrange() changes the order of 
# the rows based on the value of the columns.
flights |>
  arrange(year, month, day, dep_time)

#Likewise we can arrange a column in descending order desc()
flights |>
  arrange(desc(dep_delay))  #Will arrange dep_delay column in descending order#

#distinct() finds all the unique rows in a dataset,
# so in a technical sense, it primarily operates on the rows
flights |> distinct() #it remove duplicated rows

flights |> distinct(origin,arr_time)  #just for row of origin & arr_time

flights |> distinct(origin,arr_time,.keep_all = T)

#If you want to find the number of occurrences instead use count()
flights |> count(origin,arr_time,sort = T)

#EXERCISE
#Had an arrival delay of two or more hours
flights |> filter(arr_delay>=2)
#Flew to Houston (IAH or HOU)
flights |> filter(dest %in% c('IAH','HOU'))
#Were operated by United, American, or Delta
names(flights)
??flights
flights |> filter(carrier %in% c('UN','US','DL'))
View(flights)
#Sort flights to find the flights with the longest 
#departure delays
flights |> arrange(dep_delay)
flights |> arrange(desc(dep_delay))

# Working on the column as four verbs
# mutate(), select(), rename() and relocate()

##mutate() adding new column
flights |> mutate(
  gain = dep_delay - arr_delay,
  speed = distance / air_time * 60
)
# However, the new addition is at the last column
# To bring it closer, use '.before=1' in mutation
flights |> 
  mutate(
    gain = dep_delay - arr_delay,
    speed = distance / air_time * 60,
    .before = 1
  )
# We can also use '.after='. this put the new variables after day
flights |> 
  mutate(
    gain = dep_delay - arr_delay,
    speed = distance / air_time * 60,
    .after = day
  )

#Also, '.keep' retains only variables involved in the mutation
flights |> 
  mutate(
    gain = dep_delay - arr_delay,
    hours = air_time / 60,
    gain_per_hour = gain / hours,
    .keep = "used"
  )

## select() involves selecting some columns for usage out of
## many or thousands columns
flights |> 
  select(year, month, day)
#to select all columns between year and day
flights |> 
  select(year:day)
#Select all columns except those from year to day (inclusive):
flights |> 
  select(!year:day)
#Select all columns that are characters:
flights |> 
  select(where(is.character))
#You can rename variables as you select() them by using =
flights |> 
  select(tail_num = tailnum)

##rename()
## If you want to keep all the existing variables and just want
##  to rename a few, you can use rename() instead of select():
flights |> 
  rename(tail_num = tailnum)
#If you have a bunch of inconsistently named columns and it
#would be painful to fix them all by hand, check out janitor::clean_names()
# which provides some useful automated cleaning.

##relocate()
##Use relocate() to move variables around. You might want to 
##collect related variables together or move important variables 
##to the front. By default relocate() moves variables to the front:
flights |> 
  relocate(time_hour, air_time)
