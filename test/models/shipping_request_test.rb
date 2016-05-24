require 'test_helper'

class ShippingRequestTest < ActiveSupport::TestCase

  test "determines the correct number of boxes to use" do
    assert_equal 1, shipping_requests(:order_one).number_of_boxes
    assert_equal 1, shipping_requests(:order_two).number_of_boxes
    assert_equal 2, shipping_requests(:order_three).number_of_boxes
  end

  test "determines the correct shipping weight for estimates" do
    assert_equal 144, shipping_requests(:order_one).weight
    assert_equal 240, shipping_requests(:order_two).weight
    assert_equal 384, shipping_requests(:order_three).weight
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
  end

  test "contains a destination zip" do
    refute_nil shipping_requests(:order_one).destination_zip
    assert_equal 5, shipping_requests(:order_one).destination_zip.length
  end

  test "does not contain a dest_zip invalidates request" do
    new_request = ShippingRequest.new
    refute new_request.valid?
    assert_includes new_request.errors.keys, :destination_zip
  end

  test "when shipping request is finalized it contains a record of chosen ship type and price" do
    refute_nil shipping_requests(:order_one).chosen_type
    refute_nil shipping_requests(:order_two).chosen_type
  end

  test "when a shipping request is finalized it won't validate non-preferred shipper" do
    @our_invalid_request = ShippingRequest.new

    assert_raises(ArgumentError) {@our_bad_request.chosen_type}
  end

  test "a valid shipping request saves on completion" do
    # write a request here.
    @our_request = shipping_requests(:order_one)

    assert @our_request.valid?
    assert @our_request.save
  end

  test "an invalid request does not save on completion" do
    # write a bad request here
    @our_invalid_request = ShippingRequest.new

    refute @our_invalid_request.valid?
    refute @our_invalid_request.save
  end

  test "estimates are given to ruby as a hash" do
    # request object here
    assert_instance_of Hash, shipping_requests(:order_one).estimates
  end
end
