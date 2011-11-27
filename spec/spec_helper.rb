require 'bundler/setup'
Bundler.setup(:default, :test)
require 'sinatra'
require 'rspec'
require 'capybara/rspec'
require 'factory_girl'
require_relative 'factories'

Sinatra::Base.set :environment, :test
Sinatra::Base.set :run, false
Sinatra::Base.set :raise_errors, true
Sinatra::Base.set :logging, false

require File.join(File.dirname(__FILE__), '../rtfmroulette')

Capybara.app = Sinatra::Application.new


# factory_girl hack
ObjectSpace.each_object(Class) do |klass|
  if klass < Sequel::Model
    klass.class_eval do
      def save!
        save or raise "Could not save #{klass.name}"
      end
    end
  end
end

require 'database_cleaner'
RSpec.configure do |config|
  config.before(:suite) do
    DatabaseCleaner.strategy = :transaction
    DatabaseCleaner.clean_with(:truncation)
  end

  config.before(:each) do
    DatabaseCleaner.start
  end

  config.after(:each) do
    DatabaseCleaner.clean
  end
end
