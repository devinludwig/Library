class Book
  attr_reader(:title, :id)

  def initialize(attributes)
    @title = attributes.fetch(:title)
    @id = attributes.fetch(:id)
  end

  define_singleton_method(:all) do
    returned_books = DB.exec("SELECT * FROM book;")
    books = []
    returned_books.each do |book|
      title = book.fetch('title')
      id = book.fetch('id').to_i()
      books.push(Book.new({:title => title, :id => id}))
    end
    books.sort_by!{|i| i.title()}
  end

  define_singleton_method(:find) do |id|
    found_book = nil
    Book.all.each() do |book|
      if book.id().eql?(id)
        found_book = book
      end
    end
    found_book
  end

  define_singleton_method(:search) do |input|
    matches = []
    Book.all.each() do |book|
      if book.title.downcase.include?(input.downcase())
        matches.push(book)
      end
    end
    matches
  end

  define_method(:save) do
    result = DB.exec("INSERT INTO book (title) Values ('#{@title}') RETURNING id;")
    @id = result.first().fetch("id").to_i()
  end

  define_method(:==) do |another_book|
    title().==(another_book.title()).&(self.id().==(another_book.id()))
  end
end
