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

def calc_mongo_time_from_string_milliseconds(string_milli)
  return nil if string_milli.nil?
  t = string_milli.to_i/1000
  return Time.at(t).utc
end

reviewsColl = db[:reviews]
reviewsColl.indexes.create_one({ "id" => -1 }, :unique => true)
CSV.open(ARGV[0], :headers => true) do |rating_review_data|      
  rating_review_data.each do |rating_review| 
    r1 = Hash(rating_review)
    logger.debug r1.ai 
    r1["review_submitted_time"] = calc_mongo_time_from_string_milliseconds(r1["Review Submit Millis Since Epoch"])
    r1["review_last_updated_time"] = calc_mongo_time_from_string_milliseconds(r1["Review Last Update Millis Since Epoch"])   
    r1["developer_last_updated_time"] = calc_mongo_time_from_string_milliseconds(r1["Developer Reply Millis Since Epoch"])
    logger.debug r1["developer_last_updated_time"].ai    
    logger.debug r1["review_submitted_time"].ai
    logger.debug r1["review_last_updated_time"].ai
    firefox_version_array = r1["App Version Name"].split('.')
    if !firefox_version_array.nil?
          logger.debug firefox_version_array[0].ai
    end
    
  end
end
