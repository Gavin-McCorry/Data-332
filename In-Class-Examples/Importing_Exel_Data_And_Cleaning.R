library(readxl)
library(dplyr)
library(tidyverse)
library(tidyr)
library(ggplot2)

# clears environment on run
rm(list = ls()) 

## Setting up working directory
setwd("C:/Users/gwmcc/OneDrive/Documents/GitHub/Data-332")

df_truck <- read_excel('In-Class-Examples/Data/NP_EX_1-2.xlsx', sheet = 2, skip = 3, .name_repair = 'universal')


