require('spec_helper')

describe(Author) do
    describe(".all") do
    it("starts off with no authors") do
      expect(Author.all()).to(eq([]))
    end
  end

  describe('#name') do
    it("tells you author's name") do
      author = Author.new({:name => "Blob Trapezoid", :id => nil})
      expect(author.name()).to(eq('Blob Trapezoid'))
    end
  end

  describe('#save') do
    it("saves author to database") do
      author = Author.new({:name => "Blob Trapezoid", :id => nil})
      author.save()
      expect(Author.all()).to(eq([author]))
    end
  end

  describe('#id') do
    it("tells you a author's id") do
      author = Author.new({:name => "Blob Trapezoid", :id => nil})
      author.save()
      expect(author.id()).to(be_an_instance_of(Fixnum))
    end
  end

  describe("#==") do
    it("is the same author if it has the same name") do
      author = Author.new({:name => "Blob Trapezoid", :id => nil})
      author1 = Author.new({:name => "Blob Trapezoid", :id => nil})
      expect(author1).to(eq(author))
    end
  end
end
