require 'test_helper'

class ShippingRequestTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  # setup
  # end

  test "determines the correct number of boxes to use" do
    # set up an order with 3 items
    # set up an order with 5 items
    # set up an order with 8 items
    # (the above should probably be in our setup block)

    assert_equal 1, @order_one.number_of_boxes
    assert_equal 1, @order_two.number_of_boxes
    assert_equal 2, @order_three.number_of_boxes
  end

  test "determines the correct shipping weight for estimates" do
    assert_equal 144, @order_one.weight
    assert_equal 240, @order_two.weight
    assert_equal 384, @order_three.weight
  end

  test "contains an order id" do
    order_one = shipping_requests(:order_one)

    refute_nil order_one.order_id
    assert_instance_of Fixnum, order_one.order_id
  end

  test "does not contain an order id invalidates request" do
    new_request = ShippingRequest.new
    refute new_request.valid?
    assert_includes new_request.errors.keys, :order_id
    # assert_raises(ArgumentError) { new_request.order_id }
  end

  test "contains a shipper zipcode" do
    refute_nil shipping_requests(:order_one).origin_zip
    assert_equal 5, shipping_requests(:order_one).origin_zip.length
  end

  test "uses 98103 as the zipcode for shipper if none is provided" do
    assert_equal '98103', shipping_requests(:order_one).origin_zip
  end

  test "does not contain a shipper zip invalidates request" do
    new_request = ShippingRequest.new
    new_request.origin_zip = nil
    refute new_request.valid?
    assert_includes new_request.errors.keys, :origin_zip
    # assert_raises(ArgumentError) { @invalid_request.origin_zip }
  end

  test "contains a destination zip" do
    refute_nil shipping_requests(:order_one).destination_zip
    assert_equal 5, shipping_requests(:order_one).destination_zip.length
  end

  test "does not contain a dest_zip invalidates request" do
    new_request = ShippingRequest.new
    refute new_request.valid?
    assert_includes new_request.errors.keys, :destination_zip
    # assert_raises(ArgumentError) { @invalid_request.destination_zip }
  end

  # test "when given a request with number of boxes and weight returns an estimated shipping price" do
  #   # test object?
  #   assert_equal (run a price query on test object and fill this in.)
  # end

  test "when shipping request is finalized it contains a record of chosen ship type and price" do
    # write an API call for our API here to test saving
    # this test might need refactor

    # refute_nil @our_test_case.chosen_type
    # assert_includes(array_of_types), @our_test_case.chosen_type.keys

    # this needs to be refactored to specifically call the key used in this hash to identify shipper
    refute_nil @our_test_case.chosen_type[shipper]
  end

  test "when a shipping request is finalized it won't validate non-preferred shipper" do
    # write an API call to our API here for a bad request

    assert_raises(ArgumentError) {@our_bad_request.chosen_type}
  end

  test "a valid shipping request saves on completion" do
    # write a request here.
    assert @our_request.valid?
    assert @our_request.save
  end

  test "an invalid request does not save on completion" do
    refute @our_invalid_request.valid?
    refute @our_invalid_request.save
  end

  test "estimates are given to ruby as a hash" do
    # request object here
    assert_instance_of Hash, @order_one.estimates
  end
end
