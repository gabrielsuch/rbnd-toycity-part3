class Customer
  attr_reader :name

  @@customers = []

  def initialize(options={})
    @name = options[:name]
    add_to_customers
  end

  def self.all
    @@customers
  end

  def self.delete_all
    @@customers = []
  end

  def self.find_by_name(search)
    @@customers.select {|customer| customer.name == search}.first
  end

  def add_to_customers
    raise DuplicateProductError.new("#{name} already exists!") if Customer.find_by_name(name)
    @@customers << self
  end

  def purchase(product)
    Transaction.new(self, product)
  end

  def purchases
    Transaction.find_by_customer(self).collect { |t| t.product }
  end

end
