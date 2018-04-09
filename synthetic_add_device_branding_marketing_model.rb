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

devicesColl = db[:devices]
devicesColl.indexes.create_one({ "id" => -1 }, :unique => true) 

CSV.open(ARGV[0], :headers => true) do |device_branding_marketing_model_data|      
  device_branding_marketing_model_data.each do |dbmd| 
    d1 = Hash(dbmd)
    id_hashstr = ""
    id_hashstr +=  d1["Retail Branding"] if !d1["Retail Branding"].nil?
    id_hashstr +=  d1["Marketing Name"] if !d1["Marketing Name"].nil?
    id_hashstr +=  d1["Device"] if !d1["Device"].nil?
    id_hashstr +=  d1["Model"] if !d1["Model"].nil?

    d1["id"] = Digest::SHA2.new(256).hexdigest(id_hashstr)
    d1["synthetic_branding_plus_marketing_name"] = d1["Retail Branding"] + d1["Marketing Name"]
    logger.debug d1.ai
    logger.debug devicesColl.find({ 'id' => d1["id"] }).update_one(d1, :upsert => true ).ai
  end
end
