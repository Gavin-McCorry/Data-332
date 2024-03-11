library(readxl)
library(dplyr)
library(tidyverse)
library(tidyr)
library(ggplot2)
library(lubridate)

## Setting up working directory
setwd("C:/Users/gwmcc/OneDrive/Documents/GitHub/Data-332")

kelp_data <- read_xlsx("In-Class-Examples/Kelp_fronds Example/Data/kelp_fronds.xlsx", sheet = "abur")
fish_data <- read.csv("In-Class-Examples/Kelp_fronds Example/Data/fish.csv")

# Making fish table
fish_garibaldi <- fish_data%>%
  filter(common_name == "garibaldi")

fish_mohk <- fish_data%>%
  filter(site == "mohk")


fish_over50 <- fish_data %>%
  filter(total_count >= 50)


fish_3sp <- fish_data %>%
  filter(common_name == "garbaldi" |
           common_name == "blacksmith" |
           common_name == "black surfperch")

fish_3sp2 <- fish_data %>%
  filter(common_name %in% c("garbaldi", "blacksmith", "black surfperch"))

## not how he did it in class i dont think but i like this way :)
## Filtres rows by rows whos common_name column containts the word "black"
black_fish <- fish_data %>%
  filter(grepl("black", common_name))
