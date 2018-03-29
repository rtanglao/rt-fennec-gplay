#!/usr/bin/env ruby
require 'rubygems'
require 'awesome_print'
require 'json'
require 'time'
require 'date'
require 'mongo'
require 'csv'
require 'logger'
require 'pp'

# based on:
# https://github.com/rtanglao/2016-rtgram/blob/master/backupPublicVancouverPhotosByDateTaken.rb

logger = Logger.new(STDERR)
logger.level = Logger::DEBUG
MONGO_HOST = ENV["MONGO_HOST"]
raise(StandardError,"Set Mongo hostname in ENV: 'MONGO_HOST'") if !MONGO_HOST
MONGO_PORT = ENV["MONGO_PORT"]
raise(StandardError,"Set Mongo port in ENV: 'MONGO_PORT'") if !MONGO_PORT
MONGO_USER = ENV["MONGO_USER"]
# raise(StandardError,"Set Mongo user in ENV: 'MONGO_USER'") if !MONGO_USER
MONGO_PASSWORD = ENV["MONGO_PASSWORD"]
# raise(StandardError,"Set Mongo user in ENV: 'MONGO_PASSWORD'") if !MONGO_PASSWORD
FENNEC_GPLAY_DB = ENV["FENNEC_GPLAY_DB"]
raise(StandardError,\
      "Set Fennec gplay database name in ENV: 'FENNEC_GPLAY_DB'") \
if !FENNEC_GPLAY_DB

db = Mongo::Client.new([MONGO_HOST], :database => FENNEC_GPLAY_DB)
if MONGO_USER
  auth = db.authenticate(MONGO_USER, MONGO_PASSWORD)
  if !auth
    raise(StandardError, "Couldn't authenticate, exiting")
    exit
  end
end

reviewsColl = db[:reviews]
reviewsColl.indexes.create_one({ "id" => -1 }, :unique => true)
#CSV.open(ARGV[0], 'rb:bom|utf-16', :headers => true) do |csv|
CSV.open(ARGV[0], :headers => true) do |csv|      
  csv.each do |row| 
        r1 = Hash(row)
    logger.debug r1.ai 
        puts r1["Review Submit Millis Since Epoch".to_sym]
        str="Review Submit Millis Since Epoch".force_encoding("utf-16")
        pp r1[str]
        pp r1
        pp r1[:"Review Link"]
        pp r1["Device"]
        puts "x"
        x = {}
        x["Device"] = "lcsh92_wet_jb9"
        pp x
        puts "x class"
        puts x.class
        puts "r1 class"
        puts r1.class
        exit
        logger.debug row["Review Submit Millis Since Epoch"].ai
        t = row["Review Submit Millis Since Epoch"].to_i/1000
        logger.debug t.ai
    row["review_submitted_time"] = Time.at(t).utc
    logger.debug row["Review Submit Millis Since Epoch"].ai
    logger.debug row["review_submitted_time"].ai
    pp row
  end
end
