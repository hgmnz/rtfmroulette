require 'rubygems'
require 'bundler/setup'
Bundler.require(:default)
require 'sinatra/reloader' if development?

get '/' do
  erb :home
end
