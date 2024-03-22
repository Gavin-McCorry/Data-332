library(tidytext)
library(janeaustenr)
library(dplyr)
library(stringr)
library(tidyr)
library(ggplot2)
library(wordcloud)
library(reshape2)

setwd("C:/Users/gwmcc/OneDrive/Documents/GitHub/Data-332/In-Class-Examples/Text Analysis")


get_sentiments("afinn")
get_sentiments("bing")
get_sentiments("nrc")

# Transforming a book into a data set conating the book, word, chapter, and line
tidy_books <- austen_books() %>%
  group_by(book) %>%
  mutate(
    linenumber = row_number(),
    chapter = cumsum(str_detect(text, 
                                regex("^chapter [\\divxlc]", 
                                      ignore_case = TRUE)))) %>%
  ungroup() %>%
  unnest_tokens(word, text)

yuh <- austen_books()

# finding words whose sentiment is "joy"
nrc_joy <- get_sentiments("nrc") %>% 
  filter(sentiment == "joy")

# Filtering the book "Emma" with the list of words that sntiments are joy
tidy_books %>%
  filter(book == "Emma") %>%
  inner_join(nrc_joy) %>%
  count(word, sort = TRUE)


# counting how many positive and negative words there are in defined seections of each book
# 
jane_austen_sentiment <- tidy_books %>%
  inner_join(get_sentiments("bing")) %>%
  count(book, index = linenumber %/% 80, sentiment) %>%
  pivot_wider(names_from = sentiment, values_from = n, values_fill = 0) %>% 
  mutate(sentiment = positive - negative)


# plotting thee positiv eand negative words
ggplot(jane_austen_sentiment, aes(index, sentiment, fill = book)) +
  geom_col(show.legend = FALSE) +
  facet_wrap(~book, ncol = 2, scales = "free_x")

ggsave("sentiment_analysis_graph.png", height = 12, width = 10)

# Comparing the Three sentiment dictionaries
pride_prejudice <- tidy_books %>% 
  filter(book == "Pride & Prejudice")


# we have to use a different pattern for the AFINN lexicon then the other two since it scores the sentiment in a different way then the other 2
afinn <- pride_prejudice %>% 
  inner_join(get_sentiments("afinn")) %>% 
  group_by(index = linenumber %/% 80) %>% 
  summarise(sentiment = sum(value)) %>% 
  mutate(method = "AFINN")


bing_and_nrc <- bind_rows(
  pride_prejudice %>% 
    inner_join(get_sentiments("bing")) %>%
    mutate(method = "Bing et al."),
  pride_prejudice %>% 
    inner_join(get_sentiments("nrc") %>% 
                 filter(sentiment %in% c("positive", 
                                         "negative"))
    ) %>%
    mutate(method = "NRC")) %>%
  count(method, index = linenumber %/% 80, sentiment) %>%
  pivot_wider(names_from = sentiment,
              values_from = n,
              values_fill = 0) %>% 
  mutate(sentiment = positive - negative)

# After the chunks above we have an estimate of the net sentiment(positive - negative) in each chunk of the novel text for each sentiment lexicon
# now lets bind them together and visualize them
bind_rows(afinn, 
          bing_and_nrc) %>%
  ggplot(aes(index, sentiment, fill = method)) +
  geom_col(show.legend = FALSE) +
  facet_wrap(~method, ncol = 1, scales = "free_y")

ggsave("three_sent_compare.png", width = 6, height = 5)


# Why is the result fro NRC lexicon biased so high insentiment compared to the Bing eet al. result?
# Lets cheeck how many positv and negativ words are in each lexicon

get_sentiments("nrc") %>% 
  filter(sentiment %in% c("positive", "negative")) %>% 
  count(sentiment)

get_sentiments("bing") %>% 
  count(sentiment)

# We can see that the Bing et al. has a lot mor negative workds then th enrc does



# We can find how much each word contributs to each sentiment
bing_word_counts <- tidy_books %>%
  inner_join(get_sentiments("bing")) %>%
  count(word, sentiment, sort = TRUE) %>%
  ungroup()

bing_word_counts

# We can show this visually by pipping straight into ggplot2
bing_word_counts %>%
  group_by(sentiment) %>%
  slice_max(n, n = 10) %>% 
  ungroup() %>%
  mutate(word = reorder(word, n)) %>%
  ggplot(aes(n, word, fill = sentiment)) +
  geom_col(show.legend = FALSE) +
  facet_wrap(~sentiment, scales = "free_y") +
  labs(x = "Contribution to sentiment",
       y = NULL)

ggsave("word_contributions_graph.png", width = 7)


# as we can see "miss" is coded as a negative. This is a problem becuae "miss" can be used as a title for women
# If it is appropriate for our purposes, we can ealisy add "miss" to a custom stop-words list using bind-rows()
# we can implement this a strategy such as 
custom_stop_words <- bind_rows(tibble(word = c("miss"),  
                                      lexicon = c("custom")), 
                               stop_words)

custom_stop_words


# Wordclouds
# can make a quick and easy wordcloud using the library "wordcloud"
tidy_books %>%
  anti_join(stop_words) %>%
  count(word) %>%
  with(wordcloud(word, n, max.words = 100))

# We can make a wordcloud containing both the positve and negativee wordcoulds, and even the customs words if there are any
tidy_books %>%
  inner_join(get_sentiments("bing")) %>%
  count(word, sentiment, sort = TRUE) %>%
  acast(word ~ sentiment, value.var = "n", fill = 0) %>%
  comparison.cloud(colors = c("gray20", "gray80"),
                   max.words = 100)





