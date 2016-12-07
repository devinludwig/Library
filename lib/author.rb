class Author
  attr_reader(:name, :id)

  def initialize(attributes)
    @name = attributes.fetch(:name)
    @id = attributes.fetch(:id)
  end

  define_singleton_method(:all) do
    returned_authors = DB.exec("SELECT * FROM author;")
    authors = []
    returned_authors.each do |author|
      name = author.fetch('name')
      id = author.fetch('id').to_i()
      authors.push(Author.new({:name => name, :id => id}))
    end
    authors
  end

  define_singleton_method(:find) do |id|
    found_author = nil
    Author.all.each() do |author|
      if author.id().eql?(id)
        found_author = author
      end
    end
    found_author
  end

  define_method(:save) do
    result = DB.exec("INSERT INTO author (name) Values ('#{@name}') RETURNING id;")
    @id = result.first().fetch("id").to_i()
  end

  define_method(:==) do |another_author|
    name().==(another_author.name()).&(self.id().==(another_author.id()))
  end
end
