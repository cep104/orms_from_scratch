
require 'bundler'
Bundler.require 

require_relative "../db/seed.rb"
require_relative "../lib/tweet.rb"

DB = {:conn => SQLite3::Database.new("db/tweets.db")}
#DB[:conn].execute("some sort of SQL")

DB[:conn].results_as_hash = true

Tweet.create_table