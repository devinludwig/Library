class Patron
  attr_reader(:name, :id)

  def initialize(attributes)
    @name = attributes.fetch(:name)
    @id = attributes.fetch(:id)
  end

  define_singleton_method(:all) do
    returned_patrons = DB.exec("SELECT * FROM patron;")
    patrons = []
    returned_patrons.each do |patron|
      name = patron.fetch('name')
      id = patron.fetch('id').to_i()
      patrons.push(Patron.new({:name => name, :id => id}))
    end
    patrons.sort_by!{|i| i.name()}
  end

  define_singleton_method(:find) do |id|
    found_patron = nil
    Patron.all.each() do |patron|
      if patron.id().eql?(id)
        found_patron = patron
      end
    end
    found_patron
  end

  define_singleton_method(:find_by_name) do |name|
    found_patron = nil
    Patron.all.each() do |patron|
      if patron.name().eql?(name)
        found_patron = patron
      end
    end
    found_patron
  end

  define_singleton_method(:search) do |input|
    matches = []
    Patron.all.each() do |patron|
      if patron.name.downcase.include?(input.downcase())
        matches.push(patron)
      end
    end
    matches
  end

  define_method(:save) do
    result = DB.exec("INSERT INTO patron (name) Values ('#{@name}') RETURNING id;")
    @id = result.first().fetch("id").to_i()
  end

  define_method(:==) do |another_patron|
    name().==(another_patron.name()).&(self.id().==(another_patron.id()))
  end
end
