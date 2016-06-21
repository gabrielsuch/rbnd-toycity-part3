require_relative "../lib/errors"
require_relative "../lib/transaction"
require_relative "../lib/product"
require_relative "../lib/customer"
require "test/unit"

class TransactionTest < Test::Unit::TestCase
  def setup
    Transaction.delete_all
    Product.delete_all
    Customer.delete_all
  end

  def test_product_all_should_return_zero_when_there_is_no_products
    assert_equal(0, Transaction.all.count)
  end

  def test_product_all_should_return_all_the_products
    nanoblock = Product.new(title: "Nano Block Empire State Building", price: 49.99, stock: 12)
    walter = Customer.new(name: "Walter Latimer")
    transaction = Transaction.new(walter, nanoblock)

    assert_equal(1, Transaction.all.count)
    assert_equal(transaction, Transaction.all.first)
  end

  def test_attributes
    nanoblock = Product.new(title: "Nano Block Empire State Building", price: 49.99, stock: 12)
    firehouse = Product.new(title: "LEGO Firehouse Headquarter", price: 199.99, stock: 0)
    walter = Customer.new(name: "Walter Latimer")
    transaction = Transaction.new(walter, nanoblock)

    assert_equal(1, transaction.id)
    assert_true(transaction.product == nanoblock)
    assert_false(transaction.product == firehouse)
    assert_true(transaction.customer == walter)
    assert_equal(11, nanoblock.stock)
  end

  def test_product_out_of_stock_cannot_be_added_to_a_transaction
    walter = Customer.new(name: "Walter Latimer")
    firehouse = Product.new(title: "LEGO Firehouse Headquarter", price: 199.99, stock: 0)

    assert_raise(OutOfStockError.new("'LEGO Firehouse Headquarter' is out of stock.")) {
      transaction = Transaction.new(walter, firehouse)
    }

    assert_equal(0, Transaction.all.count)
  end

  def test_find
    nanoblock = Product.new(title: "Nano Block Empire State Building", price: 49.99, stock: 12)
    walter = Customer.new(name: "Walter Latimer")
    transaction = Transaction.new(walter, nanoblock)

    assert_equal(1, Transaction.find(1).id)
  end
end
