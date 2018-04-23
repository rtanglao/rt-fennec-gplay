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

#I would bet that is our issue.  Here are the affected model numbers. They probably use a different chip, or something.
#U.S. S8 SM-G950U1 (dreamqlteue)
#U.S. S8 plus SM-G955U1 (dream2qlteue)
#Canadian S8 SM-G950W (dreamqltecan)
#Canadian S8+ SM-G955W (dream2qltecan)
#Australian Galaxy S8 SCV36

s8_family_bug_1450793_p = year_month_day_device_all_languages_unreplied_one_and_two_star_reviews_star_last_updated_language %>% 
    filter(
      (Device == "dreamqlteue") |
      (Device == "dream2qlteue") | 
      (Device == "dreamqltecan") |
      (Device == "dream2qlteue") |
      (Device == "dream2qltecan") |
      (Device == "SCV36")
    )
p_count_pink_s8_family_device = 
  ggplot(
    data = s8_family_bug_1450793_p,
    aes(x=yyyy_mm_dd, fill="pink")) +
  geom_bar(stat = "count")+
  theme(axis.text.x = element_text(angle = 90, hjust = 1)) + 
  facet_wrap(~ Device)
