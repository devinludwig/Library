require('spec_helper')

describe(Book) do
  describe(".search") do
    it('returns an array of books whose name include an argument') do
      book = Book.new({:title => "Necronomicon", :id => nil})
      book.save()
      expect(Book.search("necro")).to(eq([book]))
    end
  end

  describe(".link") do
    it('creates a join entry in authorship table linking book with argument author') do
      book = Book.new({:title => "Necronomicon", :id => nil})
      book.save()
      author = Author.new({:name => "Lucifer", :id => nil})
      author.save()
      Book.link(author)
      fetched_book_id = (DB.exec("SELECT * FROM authorship;"))[0].fetch('book_id')
      expect(fetched_book_id).to(eq(fixnum))
    end
  end

  describe(".find") do
    it('returns a book given their id') do
      book = Book.new({:title => "Necronomicon", :id => nil})
      book.save()
      expect(Book.find(book.id())).to(eq(book))
    end
  end

  describe(".all") do
    it("starts off with no books") do
      expect(Book.all()).to(eq([]))
    end
  end

  describe('#title') do
    it("tells you book's title") do
      book = Book.new({:title => "Necronomicon", :id => nil})
      expect(book.title()).to(eq('Necronomicon'))
    end
  end

  describe('#save') do
    it("saves book to database") do
      book = Book.new({:title => "Necronomicon", :id => nil})
      book.save()
      expect(Book.all()).to(eq([book]))
    end
  end

  describe('#id') do
    it("tells you a book's id") do
      book = Book.new({:title => "Necronomicon", :id => nil})
      book.save()
      expect(book.id()).to(be_an_instance_of(Fixnum))
    end
  end

  describe("#==") do
    it("is the same book if it has the same title") do
      book = Book.new({:title => "Necronomicon", :id => nil})
      book1 = Book.new({:title => "Necronomicon", :id => nil})
      expect(book1).to(eq(book))
    end
  end
end
