require_relative "base_class"

# Warning: try to not modify this class at all
# To test run: ruby item_test.rb

class Item < BaseClass
  attr_accessor :price, :name

  def initialize(attributes = {})
    @price = attributes[:price]
    @name  = attributes[:name]
  end

  validates_presence_of :name
  validates_numericality_of :price
end
