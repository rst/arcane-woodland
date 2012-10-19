require 'test_helper'

class SpotTest < ActiveSupport::TestCase

  test "service validation" do

    spot = Spot.new
    has_valid_svcs = -> { 
      spot.valid?; 
      !spot.errors[:base].any?{ |x| x.match( /Must offer/ ) }
    }
    assert !has_valid_svcs.call

    Spot::FLAG_ATTRS.each do |attr|
      spot = Spot.new( attr => true )
      assert has_valid_svcs.call
    end

  end

  test "address" do
    assert_equal "Foo",      Spot.new( addr1: "Foo"               ).address
    assert_equal "Foo",      Spot.new(               addr2: "Foo" ).address
    assert_equal "Foo, Bar", Spot.new( addr1: "Foo", addr2: "Bar" ).address
  end

  test "address validation" do

    spot = Spot.new
    spot.valid?
    assert_not_equal [], spot.errors[:address]

    spot = Spot.new addr1: "Foo"
    spot.valid?
    assert_equal [], spot.errors[:address]

  end

end
