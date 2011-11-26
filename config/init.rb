require 'sequel'
require 'sinatra'
DB = Sequel.connect("postgres:///rtfmroulette_#{settings.environment}")
require 'sinatra/reloader' if development?
Dir['lib/*'].each do |f|
  require File.expand_path(f, "#{File.dirname(__FILE__)}/..")
end
