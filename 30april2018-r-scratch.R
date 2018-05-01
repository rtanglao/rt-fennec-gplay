library(tidyverse)
reviews = read.csv("20april2018-01nov2017-18april2018-mongo-export-reviews.csv")
one_and_two_star_reviews = reviews %>%
gt10_one_and_two_star_reviews_nocount <- 
  one_and_two_star_reviews %>% 
  add_count(Device, sort = TRUE) %>% 
  filter(n > 10) %>% 
  select(-n)
gt10_one_and_two_star_with_date <- 
  gt10_one_and_two_star_reviews_nocount %>%
  mutate(date_updated = as.Date(review_last_updated_time))
gt10_device_one_two_star_day <-
  gt10_one_and_two_star_with_date %>%
  group_by(date_updated, Device) %>%
  count()
gt10_device_plot = ggplot(
  data = gt10_device_one_two_star_day,
  aes(x=date_updated, y=n)) +
  geom_line(stat = "identity", colour="pink")+
  theme(axis.text.x = element_text(angle = 90, hjust = 1)) +
  scale_fill_brewer(palette = "Set1") + 
  scale_y_continuous(
    breaks = function(x) unique(
      floor(pretty(seq(0, (max(x) + 1) * 1.1))))) +
  facet_wrap(~ Device)
  # 4000 pixel wide plot is at:
  # https://flic.kr/p/26Hdg9e
