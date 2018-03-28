#!/usr/bin/env ruby
require 'rubygems'
require 'pp'
require 'json'
require 'time'
require 'date'
require 'mongo'
require 'csv'

# based on:
# https://github.com/rtanglao/2016-rtgram/blob/master/backupPublicVancouverPhotosByDateTaken.rb

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
      "Set Mongo instagram database name in ENV: 'FENNEC_GPLAY_DB'") \
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
#questionsColl.indexes.create_one({ "id" => -1 }, :unique => true)
#CSV.new(ARGF.file, :headers => true).each do |row|
  # string fields have quotation marks at the beginning and end
  # in order to allow embedded commas, so have to remove them i guess?
  # time fields are pacific time and in string format, need to convert to utc
  # integers are strings
  # last field has a "\n" so use chomp to eliminate it?
# CSV.foreach(ARGV[0]) do |row|
ARGF.lines do |row|
  PP::pp(row, $stderr)
        exit
end 
