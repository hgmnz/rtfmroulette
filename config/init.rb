require 'sequel'
require 'sinatra'
require 'sinatra/reloader' if development?

database_url = ENV['SHARED_DATABASE_URL'] || "postgres:///rtfmroulette_#{settings.environment}"
DB = Sequel.connect(database_url)
Sequel::Model.plugin :timestamps

Dir['lib/*'].each do |f|
  require File.expand_path(f, "#{File.dirname(__FILE__)}/..")
end

set :root, File.expand_path('..', File.dirname(__FILE__))


