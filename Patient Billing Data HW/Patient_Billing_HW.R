library(readxl)
library(dplyr)
library(tidyverse)
library(tidyr)
library(ggplot2)
library(lubridate)
library(datasets)

## Setting up working directory
setwd("C:/Users/gwmcc/OneDrive/Documents/GitHub/Data-332/Patient Billing Data HW")

billing <- read_xlsx("Data/Billing.xlsx")
patients <- read_xlsx("Data/Patient.xlsx")
visit <- read_xlsx("Data/Visit.xlsx")

df <- left_join(visit, patients, "PatientID")
df <- left_join(df, billing, "VisitID")


# Cleaning up th Reasons
df$Reason[grepl('Abrasion', df$Reason, ignore.case = TRUE)] <- 'Abrasion'
df$Reason[grepl('Allergic Reaction', df$Reason, ignore.case = TRUE)] <- 'Allergic Reaction'
df$Reason[grepl('Annual Wellness Visit', df$Reason, ignore.case = TRUE)] <- 'Annual Wellness Visit'
df$Reason[grepl('Bronchitis', df$Reason, ignore.case = TRUE)] <- 'Bronchitis'
df$Reason[grepl('Laceration', df$Reason, ignore.case = TRUE)] <- 'Laceration'
df$Reason[grepl('Cyst Removal', df$Reason, ignore.case = TRUE)] <- 'Cyst Removal'
df$Reason[grepl('Dermatitis', df$Reason, ignore.case = TRUE)] <- 'Dermatitis'
df$Reason[grepl('Diabetes', df$Reason, ignore.case = TRUE)] <- 'Diabetes'
df$Reason[grepl('Fracture', df$Reason, ignore.case = TRUE)] <- 'Fracture'
df$Reason[grepl('Hypertension', df$Reason, ignore.case = TRUE)] <- 'Hypertension'
df$Reason[grepl('Hypotension', df$Reason, ignore.case = TRUE)] <- 'Hypotension'
df$Reason[grepl('Hypothyroidism', df$Reason, ignore.case = TRUE)] <- 'Hypothyroidism'
df$Reason[grepl('Migraine', df$Reason, ignore.case = TRUE)] <- 'Migraine'
df$Reason[grepl('Removal of Sutures', df$Reason, ignore.case = TRUE)] <- 'Removal of Sutures'
df$Reason[grepl('Rhinitis', df$Reason, ignore.case = TRUE)] <- 'Rhinitis'
df$Reason[grepl('Spotted Fever Rickettsiosis', df$Reason, ignore.case = TRUE)] <- 'Spotted Fever Rickettsiosis'
df$Reason[grepl('UTI', df$Reason, ignore.case = TRUE)] <- 'UTI'
df$Reason[grepl('COPD', df$Reason, ignore.case = TRUE)] <- 'COPD'

# Pivot Tables and Graphs
# Reason for visit bases on walkin
df_pivot_reason <- df%>%
  group_by(Reason, WalkIn) %>%
  summarize(count = n())

ggplot(df_pivot_reason, aes(count, Reason, fill = WalkIn)) + 
  geom_col() + 
  ggtitle("Reason for Visits Bases On WalkIn") + 
  xlab("Count")
ggsave("Reason For Visiting-WalkIn Plot.png", width = 5)


#Reason for Visit Based on City/State or zipcode
df_pivot_reason_2 <- df%>%
  group_by(Reason, City) %>%
  summarize(count = n())

ggplot(df_pivot_reason_2, aes(count, Reason, fill = City)) + 
  geom_col() + 
  ggtitle("Reason for Visits Based On City") + 
  xlab("Count")
ggsave("Reason For Visiting Plot-City.png", width = 8)


# Total invoice amount based on reason for visit. Segmented (stacked bar chart) with it was paid. 
df_pivot_invoice <- df%>%
  group_by(Reason, InvoicePaid) %>%
  summarize(count = n(), 
            Invoice_amt = sum(InvoiceAmt))

ggplot(df_pivot_invoice, aes(Invoice_amt, Reason, fill = InvoicePaid)) + 
  geom_col() + 
  ggtitle("Total Invoice Amount Based On Reason and ff Paid") + 
  xlab("Amount In Dollars")
ggsave("Total Invoice Amount.png", width = 8)


# Own insight
# invoice item based on reason for visit
df_pivot_InvoiceItem <- df%>%
  group_by(InvoiceItem, Reason) %>%
  summarize(count = n())

ggplot(df_pivot_InvoiceItem, aes(count, InvoiceItem, fill = Reason)) + 
  geom_col() + 
  ggtitle("Invoice Item Based On Reason For Visit") + 
  ylab("Invoice Item") + 
  xlab("Count")
ggsave("Invoice Item Bases on Reason For Visit.png", width = 8)

