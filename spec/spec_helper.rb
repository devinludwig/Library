require('rspec')
require('pry')
require('book')
require('author')
require('patron')
require('pg')
require('capybara/rspec')
require('./app')
Capybara.app = Sinatra::Application
set(:show_exceptions, false)

RSpec.configure do |config|
  config.after(:each) do
    DB.exec('DELETE FROM book *;')
    DB.exec('DELETE FROM patron *;')
    DB.exec('DELETE FROM author *;')
  end
end
