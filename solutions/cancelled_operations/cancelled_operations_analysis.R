library(tidyverse)
library(janitor)
library(gapminder)

# Loading data
load("~/university-work/ds-for-health-practice/week_2/cancelled_operations/phs_cancelled_messy.Rda")

# base::library() we're already familiar with for loading packages
#  base::names() allows us to view all the column names or variables in our dataet
#  dplyr::distinct() for exploring the unique values in our columns or variables
#  dplyr::filter() allows us to subset data by filtering out rows based on variable criteria
#  dplyr::select() allows us to subset data by selecting specific columns or variables
#  dplyr::glimpse() provides information on dimensions, data types and a small preview
#  dplyr::arrange() &  dplyr::desc()  lets you sort your data (default is ascending order)
#  tidyr::pivot_longer() lengthens the data, increasing rows and decreasing columns
#  tidyr::pivot_wider() widens the data, increasing columns and decreasing rows
#  dplyr::mutate() for changing or adding columns
#  stringr::str_replace() for finding and replacing strings (text) in your data
#  ggplot2::ggplot() &  ggplot2::aes() lets R know you are about to make a plot and what you're going to plot
# ggplot2::geom_point() lets R know you want to make a scatter plot
# base::replace() for finding and replacing values in your data

# 1. Exploring data
cancelled_messy %>% 
  names()

cancelled_messy %>% 
  distinct(Measure)

typo <- cancelled_messy %>% 
  filter(Measure == "TotalOprations") 

# Grampian data
grampian <- cancelled_messy %>% 
  select(Month, Measure, "NHS Grampian")

cancelled_messy %>% 
  glimpse()

sorted_month <- cancelled_messy %>% 
  arrange(desc(Month))

# 2. Tidying data

# Clean names
cancelled_messy <- clean_names(cancelled_messy)

# Fix spelling mistake
cancelled_messy <- cancelled_messy %>% 
  mutate(Measure = str_replace(Measure, "Opration", "Operation"))

cancelled_tidy <- cancelled_messy %>% 
  pivot_longer(cols = "NHS Ayrshire and Arran" : "The Golden Jubilee National Hospital", names_to = "health_board") %>% 
  pivot_wider(names_from = Measure, values_from = value)

# 3. Plot exploration

cancelled_tidy %>% 
  ggplot(aes(x = Month, y = TotalOperations)) +
  geom_point()

# Explore max TotalOperations

check_total_op <- cancelled_tidy %>% 
  arrange(desc(TotalOperations)) %>% 
  filter(health_board == "NHS Grampian")

# fix mistaken high value
cancelled_data <- cancelled_tidy %>% 
  mutate(TotalOperations = replace(TotalOperations, TotalOperations == 356666, 3566))

cancelled_data %>% 
  ggplot(aes(x = Month, y = NonClinicalCapacityReason, group = health_board, colour = health_board)) +
  geom_line()


# check sum of total observations
check_totals <- cancelled_data %>% 
  mutate(totals_check = CancelledByPatientReason + ClinicalReason + NonClinicalCapacityReason + OtherReason) %>% 
  filter(TotalCancelled != totals_check)

# ========================== gapminder practice ================================

gap_2007 <- gapminder %>% 
  filter(year == 2007) %>% 
  arrange(desc(lifeExp))

gap_subset <- gapminder %>% 
  filter(year %in% c(1952, 2007) & country == 'Japan')



















