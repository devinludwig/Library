require('sinatra')
require('sinatra/reloader')
require('./lib/book')
require('./lib/patron')
require('./lib/author')
also_reload('lib/**/*.rb')
require('pg')

DB = PG.connect({:dbname => 'library_test'})


get('/') do
  erb(:index)
end

post('/patron') do
  user_name_input = params.fetch("name_input")
  @patron = Patron.find_by_name(user_name_input)
  if @patron == nil
    @patron = Patron.new({:name => user_name_input, :id => nil})
    @patron.save()
  end
  erb(:patron)
end

get('/admin') do
  @patrons = Patron.all()
  @books = Book.all()
  erb(:admin)
end

post('/patron_search_result') do
  @input = params.fetch('patron_search')
  @results = Patron.search(@input)
  erb(:patron_search_result)
end
