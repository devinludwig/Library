require('spec_helper')

describe(Book) do
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
