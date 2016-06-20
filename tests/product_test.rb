require_relative "../lib/product"
require_relative "../lib/errors"
require "test/unit"

class ProductTest < Test::Unit::TestCase
  def setup
    Product.delete_all
  end

  def test_product_all_should_return_zero_when_there_is_no_products
    assert_equal(0, Product.all.count)
  end

  def test_product_all_should_return_all_the_products
    Product.new(title: "LEGO Iron Man vs. Ultron", price: 22.99, stock: 55)
    Product.new(title: "Nano Block Empire State Building", price: 49.99, stock: 12)
    Product.new(title: "LEGO Firehouse Headquarter", price: 199.99, stock: 0)

    assert_equal(3, Product.all.count)
  end

  def test_add_a_duplicated_product_should_raise_an_exception
    Product.new(title: "Gabe's Juice")

    assert_raise(DuplicateProductError.new("Gabe's Juice already exists!")) {
      Product.new(title: "Gabe's Juice")
    }
  end

  def test_find_by_an_unexistent_product_should_return_nil
    assert_nil(Product.find_by_title("Unexistent"))
  end

  def test_find_by_an_existent_product_should_return_it
    Product.new(title: "Nano Block Empire State Building", price: 49.99, stock: 12)
    nanoblock = Product.find_by_title("Nano Block Empire State Building")

    assert_not_nil(nanoblock)
    assert_equal("Nano Block Empire State Building", nanoblock.title)
    assert_equal(49.99, nanoblock.price)
    assert_equal(12, nanoblock.stock)
  end

  def test_in_stock
    nanoblock = Product.new(title: "Nano Block Empire State Building", price: 49.99, stock: 12)
    firehouse = Product.new(title: "LEGO Firehouse Headquarter", price: 199.99, stock: 0)
    products_in_stock = Product.in_stock

    assert_true(nanoblock.in_stock?)
    assert_false(firehouse.in_stock?)
    assert_true(products_in_stock.include?(nanoblock))
    assert_false(products_in_stock.include?(firehouse))
  end
end
