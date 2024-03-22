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
