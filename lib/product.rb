class Product
  attr_reader :title, :price, :stock

  @@products = []

  def initialize(options={})
    @title = options[:title]
    @price = options[:price]
    @stock = options[:stock]
    add_to_products
  end

  def self.all
    @@products
  end

  def self.delete_all
    @@products = []
  end

  def self.find_by_title(search)
    @@products.find { |product| product.title == search }
  end

  def self.in_stock
    @@products.select { |product| product.in_stock? }
  end

  def sell
    @stock -= 1
  end

  def in_stock?
    stock > 0
  end

  private

  def add_to_products
    raise DuplicateProductError.new("#{title} already exists!") if Product.find_by_title(title)
    @@products << self
  end
end
