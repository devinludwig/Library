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

post('/admin') do
  @author_added = params.fetch('author')
  @title_added = params.fetch('title')
  new_book = Book.new({:title => @title_added, :id => nil})
  new_book.save()
  new_author = Author.new({:name => @author_added, :id => nil})
  new_author.save()
  new_book.link(new_author)
  erb(:admin)
end

post('/patron_search_result') do
  @input = params.fetch('patron_search')
  @results = Patron.search(@input)
  erb(:patron_search_result)
end

get('/add_new_book') do
  erb(:add_new_book)
end
