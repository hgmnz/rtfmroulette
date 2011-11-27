require 'rubygems'
require 'bundler/setup'
Bundler.require(:default)
require File.expand_path('./config/init.rb', File.dirname(__FILE__))

require 'sinatra/content_for'

get '/' do
  erb :home
end

get '/roulette' do
  @source = Source.random
  redirect "/docs/#{@source.id}"
end

get '/docs/:id' do |id|
  @source = Source.find(id: id)
  erb :doc
end

post '/docs/:id/upvote' do |id|
  Source.find(id: id).upvote
end

post '/docs/:id/downvote' do |id|
  Source.find(id: id).downvote
end
