# rt-fennec-gplay
scripts for working with firefox for android google play reviews and replies

## 2018-04-19
November 2017 non replied to reviews: 12487 

```js
{"synthetic_developer_should_have_replied_but_did_not_reply" : true}
```
12487 documents

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

