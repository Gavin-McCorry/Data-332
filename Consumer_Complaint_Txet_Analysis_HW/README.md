# Customer Complaints Sentiment Analysis

## Author
Gavin McCorry

## Introduction
We will analyze the sentiments of different customer complaints about different financial products such as credit cars and mortgage loans from over 2500 companies

## Dictionary
The columns that we used are:
1. consumer.complaint.narrative: The complaint recorded from the customer
2. Complaint.ID: The unique ID number of the complaint
3. company: The company that the complaint was filed for
4. product: The product that the complaint was filed for
5. state: The state the complaint was filed in

## Data Cleaning
1. consumer.complaint.narrative
* The data had a lot of rows that had an empty consumer.complaint.narrative column, so I removed those rows from the data set

```
df <- df %>%
  filter(Consumer.complaint.narrative != "")
```

2. words
* Next to be able to perform an effective sentiment analysis I had to split up all the words in the consumer.complaint.narrative column to be able to compare each word to the sentiment dictionary. To do this I unnested the words in the consumer.complaint.narrative column into a new column word. 

```
tidy_complaints <- df %>%
  unnest_tokens(word, Consumer.complaint.narrative)
```

## Sentiment Analysis
* To perform the sentiment analysis I created 3 pivot tables where I inner joined the sentiment dictionary "bing" and the cleaned data frame. From there the sentiment of each word was counted as either positive or negative. From there the data was sorted based on different parameters for each table and put into a new column sentiment, defined as positive - negative, to get the overall sentiment score. The 3 different parameters used were Company, Product, and State, each recieving there own pivot table.
* For the Company pivot table, since there is over 2600 different companies in the data set, and it would be hard to show all of them, I took a random sample of 50 to give an idea of the sentiment spread across the companies
```
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
```

