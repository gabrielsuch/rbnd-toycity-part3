require_relative "../lib/customer"
require_relative "../lib/product"
require_relative "../lib/transaction"
require_relative "../lib/errors"
require "test/unit"

class CustomerTest < Test::Unit::TestCase
  def setup
    Customer.delete_all
    Product.delete_all
    Transaction.delete_all
  end

  def test_customer_all_should_return_zero_when_there_is_no_customers
    assert_equal(0, Customer.all.count)
  end

  def test_customer_all_should_return_all_the_customers
    Customer.new(name: "Walter Latimer")
    Customer.new(name: "Julia Van Cleve")

    assert_equal(2, Customer.all.count)
  end

  def test_add_a_duplicated_customer_should_raise_an_exception
    Customer.new(name: "Walter Latimer")

    assert_raise(DuplicateProductError.new("Walter Latimer already exists!")) {
      Customer.new(name: "Walter Latimer")
    }
  end

  def test_find_by_an_unexistent_customer_should_return_nil
    assert_nil(Customer.find_by_name("Unexistent"))
  end

  def test_find_by_an_existent_customer_should_return_it
    Customer.new(name: "Walter Latimer")
    walter = Customer.find_by_name("Walter Latimer")
    assert_equal("Walter Latimer", walter.name)
  end

  def test_purchase
    assert_equal(0, Transaction.all.count)

    walter = Customer.new(name: "Walter Latimer")
    nanoblock = Product.new(title: "Nano Block Empire State Building", price: 49.99, stock: 12)
    walter.purchase(nanoblock)

    assert_equal(1, Transaction.all.count)
  end

  def test_purchases
    lego = Product.new(title: "LEGO Iron Man vs. Ultron", price: 22.99, stock: 55)
    nanoblock = Product.new(title: "Nano Block Empire State Building", price: 49.99, stock: 12)
    firehouse = Product.new(title: "LEGO Firehouse Headquarter", price: 199.99, stock: 10)
    walter = Customer.new(name: "Walter Latimer")

    walter.purchase(lego)
    walter.purchase(nanoblock)
    walter.purchase(firehouse)

    assert_true(walter.purchases.include? lego)
    assert_true(walter.purchases.include? nanoblock)
    assert_true(walter.purchases.include? firehouse)
  end
end
