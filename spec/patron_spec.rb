require('spec_helper')

describe(Patron) do
    describe(".all") do
    it("starts off with no patrons") do
      expect(Patron.all()).to(eq([]))
    end
  end

  describe('#name') do
    it("tells you patron's name") do
      patron = Patron.new({:name => "Blob Trapezoid", :id => nil})
      expect(patron.name()).to(eq('Blob Trapezoid'))
    end
  end

  describe('#save') do
    it("saves patron to database") do
      patron = Patron.new({:name => "Blob Trapezoid", :id => nil})
      patron.save()
      expect(Patron.all()).to(eq([patron]))
    end
  end

  describe('#id') do
    it("tells you a patron's id") do
      patron = Patron.new({:name => "Blob Trapezoid", :id => nil})
      patron.save()
      expect(patron.id()).to(be_an_instance_of(Fixnum))
    end
  end

  describe("#==") do
    it("is the same patron if it has the same name") do
      patron = Patron.new({:name => "Blob Trapezoid", :id => nil})
      patron1 = Patron.new({:name => "Blob Trapezoid", :id => nil})
      expect(patron1).to(eq(patron))
    end
  end
end
