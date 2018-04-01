# rt-fennec-gplay
scripts for working with firefox for android google play reviews and replies

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

