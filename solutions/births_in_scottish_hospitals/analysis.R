library(tidyverse)

births_df <- read_csv("https://www.opendata.nhs.scot/dataset/df10dbd4-81b3-4bfa-83ac-b14a5ec62296/resource/8654b6d8-9765-4ced-8e9b-4611aa4596eb/download/12.1_delivery.csv")

births_df %>% 
  group_by(AgeGroup)
  count()
  

