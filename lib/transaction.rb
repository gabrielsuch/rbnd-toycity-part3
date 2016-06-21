class Transaction
  attr_reader :id, :customer, :product

  @@next_id = 0;
  @@transactions = []

  def initialize(customer, product)
    @id = Transaction.next_id
    @customer = customer
    @product = product
    add_to_transactions
  end

  def self.all
    @@transactions
  end

  def self.delete_all
    @@next_id = 0
    @@transactions = []
  end

  def self.find(search)
    @@transaction.select { |transaction| transaction.id == search }.first
  end

  private
  def self.next_id
    @@next_id += 1
    @@next_id
  end

  def add_to_transactions
    raise OutOfStockError.new("'#{product.title}' is out of stock.") unless product.in_stock?
    @@transactions << self
    product.sell
  end
end
