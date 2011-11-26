require 'sequel'
require 'sinatra'
database_url = ENV['SHARED_DATABASE_URL'] || "postgres:///rtfmroulette_#{settings.environment}"
DB = Sequel.connect(database_url)
require 'sinatra/reloader' if development?
Dir['lib/*'].each do |f|
  require File.expand_path(f, "#{File.dirname(__FILE__)}/..")
end
