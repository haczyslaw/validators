require_relative "item"
require "minitest/autorun"

# Remark: do not modify this test
class TestItem < Minitest::Test

  def test_validation
    item1 = Item.new(:name => "Guitar")
    item2 = Item.new(:price => 55)
    item3 = Item.new()
    item4 = Item.new(:name => "Guitar", :price => "ABC")
    item5 = Item.new(:name => "Guitar", :price => 55)

    assert !item1.valid?
    assert item1.errors == ["price must be number"]

    assert !item2.valid?
    assert item2.errors == ["name can't be blank"]

    assert !item3.valid?
    assert item3.errors == ["name can't be blank", "price must be number"]

    assert !item4.valid?
    assert item4.errors == ["price must be number"]

    assert item5.valid?
  end
end
