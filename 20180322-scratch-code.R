library(tidyverse)
reviews = read.csv("20april2018-01nov2017-18april2018-mongo-export-reviews.csv")
csv)
# remove 3, 4 and 5 star reviews
one_and_two_star_reviews = reviews %>%
  filter(star_rating < 3)
all_languages_unreplied_one_and_two_star_reviews = one_and_two_star_reviews %>% 
  filter(synthetic_developer_should_have_replied_but_did_not_reply == "true")
english_one_and_two_star_reviews = one_and_two_star_reviews %>%
  filter(Reviewer.Language == "en")
unreplied_english_one_and_two_star_reviews = english_one_and_two_star_reviews %>%
  filter(synthetic_developer_should_have_replied_but_did_not_reply == "true")  
device_all_languages_unreplied_one_and_two_star_reviews_star_last_updated_language = 
  all_languages_unreplied_one_and_two_star_reviews %>% 
  select(id, star_rating, review_last_updated_time, Reviewer.Language, Device)
year_month_day_device_all_languages_unreplied_one_and_two_star_reviews_star_last_updated_language = 
  device_all_languages_unreplied_one_and_two_star_reviews_star_last_updated_language %>% 
  mutate(yyyy_mm_dd = strftime(review_last_updated_time,'%Y-%m-%d'))
p = ggplot(data=
year_month_day_device_all_languages_unreplied_one_and_two_star_reviews_star_last_updated_language,
              aes(x=yyyy_mm_dd)) +
                geom_bar(stat = "count")+
  theme(axis.text.x = element_text(angle = 90, hjust = 1)) +
  scale_fill_brewer(palette = "Set1")
p_red = ggplot(data=
                     year_month_day_device_all_languages_unreplied_one_and_two_star_reviews_star_last_updated_language,
                   aes(x=yyyy_mm_dd, fill="red")) +
  geom_bar(stat = "count")+
  theme(axis.text.x = element_text(angle = 90, hjust = 1))
p_red_device = ggplot(data=
                 year_month_day_device_all_languages_unreplied_one_and_two_star_reviews_star_last_updated_language,
               aes(x=yyyy_mm_dd, fill="red")) +
  geom_bar(stat = "count")+
  theme(axis.text.x = element_text(angle = 90, hjust = 1)) + 
  facet_wrap(~ Device)
