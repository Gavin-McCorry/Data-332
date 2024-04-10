library(tidytext)
library(janeaustenr)
library(dplyr)
library(stringr)
library(tidyr)
library(ggplot2)
library(wordcloud)
library(reshape2)
library(readxl)
library(ggplot2)

setwd("C:/Users/gwmcc/OneDrive/Documents/GitHub/Data-332/Consumer_Complaint_Txet_Analysis_HW/Data")

df <- read.csv("Consumer_Complaints.csv")
df <- df %>%
  filter(Consumer.complaint.narrative != "")

get_sentiments("bing")
get_sentiments("nrc")

tidy_complaints <- df %>%
  unnest_tokens(word, Consumer.complaint.narrative)

# Saving data as rds files
saveRDS(tidy_complaints, file = "tidy_complaints.rds")
saveRDS(customer_complaints_sentiment_sample_company, file = "sentiment_analysis_company.rds")
saveRDS(customer_complaints_sentiment_product, file = "sentiment_analysis_product.rds")
saveRDS(customer_complaints_sentiment_state, file = "sentiment_analysis_state.rds")

# Pivot tables for sentimnt analysises based on Company, Product, and State
customer_complaints_sentiment_company <- tidy_complaints %>%
  inner_join(get_sentiments("bing"), relationship = "many-to-many") %>%
  count(Company,sentiment) %>%
  pivot_wider(names_from = sentiment, values_from = n, values_fill = 0) %>% 
  mutate(sentiment = positive - negative)
customer_complaints_sentiment_sample_company <- sample_n(customer_complaints_sentiment, size = 50)


customer_complaints_sentiment_product <- tidy_complaints %>%
  inner_join(get_sentiments("bing"), relationship = "many-to-many") %>%
  count(Product,sentiment) %>%
  pivot_wider(names_from = sentiment, values_from = n, values_fill = 0) %>% 
  mutate(sentiment = positive - negative)

customer_complaints_sentiment_state <- tidy_complaints %>%
  inner_join(get_sentiments("bing"), relationship = "many-to-many") %>%
  count(State,sentiment) %>%
  pivot_wider(names_from = sentiment, values_from = n, values_fill = 0) %>% 
  mutate(sentiment = positive - negative)


# Sentiment Analysis Graphs
ggplot(customer_complaints_sentiment_sample_company, aes(Company, sentiment, fill = Company)) +
  geom_col(show.legend = FALSE) +
  theme(axis.text.x = element_text(angle = 90, size = 5))+
  ylab("Sentiment Score") + 
  ggtitle("Sentiment Score Per Company")
ggsave("customer_complaints_sent__company_analysis.png", width = 6)

ggplot(customer_complaints_sentiment_product, aes(Product, sentiment, fill = Product)) +
  geom_col(show.legend = FALSE) +
  theme(axis.text.x = element_text(angle = 90, size = 5)) +
  ylab("Sentiment Score") +
  ggtitle("Sentiment Score Per Product")
ggsave("customer_complaints_sent_product_analysis.png", width = 6)


ggplot(customer_complaints_sentiment_state, aes(State, sentiment, fill = State)) +
  geom_col(show.legend = FALSE) +
  theme(axis.text.x = element_text(angle = 90, size = 5)) +
  ylab("Sentiment Score") +
  ggtitle("Sentiment Score Per State")
ggsave("customer_complaints_sent_state_analysis.png", width = 6)


# Word Cloud
tidy_complaints %>%
  inner_join(get_sentiments("bing")) %>%
  count(word, sentiment, sort = TRUE) %>%
  acast(word ~ sentiment, value.var = "n", fill = 0) %>%
  comparison.cloud(colors = c("gray20", "gray80"),
                   max.words = 100)
        