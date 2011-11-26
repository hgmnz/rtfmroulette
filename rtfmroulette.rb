require 'rubygems'
require 'bundler/setup'
Bundler.require(:default)
require File.expand_path('./config/init.rb', File.dirname(__FILE__))

get '/' do
  erb :home
end

get '/roulette' do
  @source = Source.random
  redirect "/docs/#{@source.id}"
end

get '/docs/:id' do |id|
  @source = Source.find(id: id)
  erb :article
end
