# Load packages
library(tidyverse)
library(lubridate)
library(gt)

# Read in the cancellations dataset
cancelled_raw <- read_csv("https://www.opendata.nhs.scot/dataset/479848ef-41f8-44c5-bfb5-666e0df8f574/resource/0f1cf6b1-ebf6-4928-b490-0a721cc98884/download/cancellations_by_board_february_2022.csv")
hb <- read_csv("https://www.opendata.nhs.scot/dataset/9f942fdb-e59e-44f5-b534-d6e17229cc7b/resource/652ff726-e676-4a20-abda-435b98dd7bdc/download/hb14_hb19.csv")

cancelled <- cancelled_raw %>%
  # Join cancelled to hb
  left_join(hb, by = c("HBT" = "HB")) %>%
  # Select the variables we are interested in 
  select(Month,
         HBName,
         TotalOperations,
         TotalCancelled) %>%
  # Filter the values we are interested in 
  # filter(HBName == "NHS Borders") %>%
  # Reformat the month column 
  mutate(Month = ymd(Month, truncated = TRUE))

cancelled %>%
  ggplot(aes(x = Month, y = TotalOperations, color = HBName)) +
  geom_col() +
  facet_wrap(~HBName, scales = "free") +
  theme_bw()


# =============================== practice challenge solution ============================

cancelled %>% 
  filter(HBName == 'NHS Grampian') %>% 
  mutate(year = year(Month)) %>% 
  ggplot(aes(x = month(Month), y = TotalOperations, group = year, color = factor(year))) +
  scale_x_continuous(breaks = c(1:12)) +
  geom_line() +
  labs(x = "Month", y = "TotalOperations", color = "Year", title = "Annual Trends for Total Operations: NHS Grampian") +
  theme_minimal()


# ============================ tables =========================================

cancelled %>%
  head() %>%
  gt() 




