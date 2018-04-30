# rt-fennec-gplay
scripts for working with firefox for android google play reviews and replies

## 2018-04-29
### 2018-04-29 how to get counts

```R
library(tidyverse)
reviews = read.csv("20april2018-01nov2017-18april2018-mongo-export-reviews.csv")
one_and_two_star_reviews = reviews %>%
filter(star_rating < 3)
install.packages('padr')
library(padr)
one_and_two_star_with_date <- one_and_two_star_reviews %>%
mutate(date_updated = as.Date(review_last_updated_time))

one_two_star_day <-
  one_and_two_star_with_date %>%
  group_by(date_updated) %>%
   count()
```

#### 2018-04-29 Output:

```R
> head(one_two_star_day)
# A tibble: 6 x 2
# Groups:   date_updated [6]
  date_updated     n
  <date>       <int>
1 2017-11-01      62
2 2017-11-02      41
3 2017-11-03      43
4 2017-11-04      57
5 2017-11-05      48
6 2017-11-06      54
```

#### 2018-04-29 Plot:

```R
p = ggplot(
  data =one_two_star_day,
           aes(x=date_updated, y=n)) +
  geom_line(stat = "identity")+
  theme(axis.text.x = element_text(angle = 90, hjust = 1)) +
  scale_fill_brewer(palette = "Set1")
```

## 2018-04-22

### 2018-04-22 some code for some plots

```R
# warning some dead ends and sloppy code  ahead :-) 
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
```

## 2018-04-19

### 2018-04-19 English only, 1 and 2 star: Non replied to reviews November 14, 2017 - April 18, 2018 is: 3962

* mongodb query:

```js
{"synthetic_developer_should_have_replied_but_did_not_reply" : true, 
  "Review Last Update Date and Time": {$gte : "2017-11-14 00:00:00 UTC"},
  "star_rating": { $lt : 3},
  "Reviewer Language": "en"
}
```

### 2018-04-19 1 and 2 star: Non replied to reviews November 14, 2017 - April 18, 2018 is: 13130

* mongodb query:

```js
{"synthetic_developer_should_have_replied_but_did_not_reply" : true, 
  "Review Last Update Date and Time": {$gte : "2017-11-14 00:00:00 UTC"},
  "star_rating": { $lt : 3}
}
```

### 2018-04-19 Non replied to reviews November 14, 2017 - April 18, 2018 is: 45184

* November 14, 2017 was the Firefox 57 for Android release date.
* mongodb query

```js
{"synthetic_developer_should_have_replied_but_did_not_reply" : true, 
  "Review Last Update Date and Time": {$gte : "2017-11-14 00:00:00 UTC"}}
```

### 2018-04-19 Non replied to reviews November 1, 2017 - April 18, 2018 is 48192

* ```3334  + 6529 + 6165 + 9629 + 10048 + 12487 = 48192```


#### November 2017 non replied to reviews: 12487 

```bash
./read-reviews-replies.rb utf8-nov-2017-downloaded-april192018-reviews_reviews_org.mozilla.firefox_201711.csv\
 2>nov-2017-downloaded-19april2018_stderr.txt
```

```js
{"synthetic_developer_should_have_replied_but_did_not_reply" : true}
```
* 12487 documents

#### December 2017 non replied to reviews = 22535 - 12487 = 10048

* same query as November returns 22535 documents

```bash
./read-reviews-replies.rb utf8-dec-2017-downloaded-april192018-reviews_reviews_org.mozilla.firefox_201712.csv\
 2>dec-2017-downloaded-19april2018_stderr.txt
```

#### January 2018 non replied to reviews = 32164 - 22535 = 9629

```bash
 ./read-reviews-replies.rb utf8-jan-2018-downloaded-april192018-reviews_reviews_org\
 .mozilla.firefox_201801.csv 2> jan-2018-downloaded-19april2018_stderr.txt
``` 

#### February 2018 non replied to reviews = 38329 - 32164 = 6165 

```bash
 ./read-reviews-replies.rb utf8-feb-2018-downloaded-april192018-reviews_reviews_org.mozilla.firefox_201802.csv  
  2>feb-2018-downloaded-19april2018_stderr.txt
```

#### March 2018 non replied to reviews = 44858 - 38329 =  6529

```bash
./read-reviews-replies.rb utf8-mar-2018-downloaded-april192018-reviews_reviews_org.mozilla.firefox_201803.csv\
 2>mar-2018-downloaded-19april2018_stderr.txt
```
#### April 2018 non replied to reviews =  48192 - 44858 =  3334

```bash
 ./read-reviews-replies.rb utf8-apr-2018-downloaded-april192018-reviews_reviews_org.mozilla.firefox_201804.csv\
  2>apr-2018-downloaded-19april2018_stderr.txt
 ```

### 2018-04-19 117077-6= 117071 is the number of ratings (including with reviews and without reviews i.e. just star rating)

```bash
rtanglao@roland-SURFACE-38263:~/GIT/rt-fennec-gplay$ wc -l utf8*april19*
```

```
    9238 utf8-apr-2018-downloaded-april192018-reviews_reviews_org.mozilla.firefox_201804.csv
   22246 utf8-dec-2017-downloaded-april192018-reviews_reviews_org.mozilla.firefox_201712.csv
   17014 utf8-feb-2018-downloaded-april192018-reviews_reviews_org.mozilla.firefox_201802.csv
   22227 utf8-jan-2018-downloaded-april192018-reviews_reviews_org.mozilla.firefox_201801.csv
   18201 utf8-mar-2018-downloaded-april192018-reviews_reviews_org.mozilla.firefox_201803.csv
   28151 utf8-nov-2017-downloaded-april192018-reviews_reviews_org.mozilla.firefox_201711.csv
  117077 total
```

### 2018-04-19 refresh files from google play (stored on google drive for PPI reasons) which are utf16 and convert to utf8

```bash
iconv -f UTF-16 -t UTF-8  nov-2017-downloaded-april192018-reviews_reviews_org.mozilla.firefox_201711.csv > utf8-nov-2017-downloaded-april192018-reviews_reviews_org.mozilla.firefox_201711.csv
iconv -f UTF-16 -t UTF-8 dec-2017-downloaded-april192018-reviews_reviews_org.mozilla.firefox_201712.csv  > utf8-dec-2017-downloaded-april192018-reviews_reviews_org.mozilla.firefox_201712.csv
iconv -f UTF-16 -t UTF-8 jan-2018-downloaded-april192018-reviews_reviews_org.mozilla.firefox_201801.csv  > utf8-jan-2018-downloaded-april192018-reviews_reviews_org.mozilla.firefox_201801.csv
iconv -f UTF-16 -t UTF-8 feb-2018-downloaded-april192018-reviews_reviews_org.mozilla.firefox_201802.csv  > utf8-feb-2018-downloaded-april192018-reviews_reviews_org.mozilla.firefox_201802.csv
iconv -f UTF-16 -t UTF-8 mar2018-downloaded-april192018-reviews_reviews_org.mozilla.firefox_201803.csv  > utf8-mar-2018-downloaded-april192018-reviews_reviews_org.mozilla.firefox_201803.csv
iconv -f UTF-16 -t UTF-8 apr-2018-downloaded-april192018-reviews_reviews_org.mozilla.firefox_201804.csv  > utf8-apr-2018-downloaded-april192018-reviews_reviews_org.mozilla.firefox_201804.csv
```

## 2018-04-08

```bash
 ./read-reviews-replies.rb utf_8_reviews_reviews_org.mozilla.firefox_201801.csv 2>out.txt
iconv -f UTF-16 -t UTF-8  supported_devices.csv >utf8_supported_devices.csv
./synthetic_add_device_branding_marketing_model.rb utf8_supported_devices.csv
```

## 2018-03-29
### 2018-03-29 convert from utf-16 to utf-8
not sure why the file was in utf-16 (because i edited it in emacs on the windows side?)

```bash
iconv -f UTF-16 -t UTF-8 reviews_reviews_org.mozilla.firefox_201801.csv >out.csv
```

## 2018-03-28
## 2018-03-28 columns of the spreadsheet

**NOTE there is no OS version sad face**

```

                             "Package Name" => "org.mozilla.firefox",
                         "App Version Code" => "2015506297",
                         "App Version Name" => "55.0.2",
                        "Reviewer Language" => "pt",
                                   "Device" => "j1x3g",
              "Review Submit Date and Time" => "2016-06-08T19:04:33Z",
         "Review Submit Millis Since Epoch" => "1465412673276",
         "Review Last Update Date and Time" => "2018-01-01T00:03:44Z",
    "Review Last Update Millis Since Epoch" => "1514765024578",
                              "Star Rating" => "2",
                             "Review Title" => nil,
                              "Review Text" => "Era muito bom,depois da atualiza\u00E7\u00E3o ficou lento,\u00E9 uma pena pq vou desinstalar.",
            "Developer Reply Date and Time" => nil,
       "Developer Reply Millis Since Epoch" => nil,
                     "Developer Reply Text" => nil,
                              "Review Link" => "https://play.google.com/apps/publish?account=7083182635971239206#ReviewDetailsPlace:p=org.mozilla.firefox&reviewid=gp:AOqpTOF0Hj5dChztXiSpcu6Wt8Bs77n_lXIA7d-jnttD7LrWRPGBlmN8KJzLwpQNp_SKFQSRvg97qlx59u0fOQ"
```
## 2018-03-27

### 2018-03-27 how to run the database:

```bash
cd /home/rtanglao/MONGODB_DATABASES/FENNEC_GPLAY
sudo mongod --dbpath . &
```

