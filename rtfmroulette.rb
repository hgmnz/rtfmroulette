require 'rubygems'
require 'bundler/setup'
Bundler.require(:default)
require 'sinatra/reloader' if development?

get '/' do
  erb :home
end

get '/roulette' do
  @article = { title: 'This is a test', body: 'This is the body of the manual' }
  erb :article
end
