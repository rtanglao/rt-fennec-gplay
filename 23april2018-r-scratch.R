count_p_red_device = year_month_day_device_all_languages_unreplied_one_and_two_star_reviews_star_last_updated_language %>% 
  add_count(Device, sort = TRUE) %>% 
  filter(n > 100)
p_count_red_device = 
  ggplot(
    data = count_p_red_device,
    aes(x=yyyy_mm_dd, fill="red")) +
  geom_bar(stat = "count")+
  theme(axis.text.x = element_text(angle = 90, hjust = 1)) + 
  facet_wrap(~ Device)

