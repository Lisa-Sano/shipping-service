require 'test_helper'
require 'active_shipping'

class ShippingRequestTest < ActiveSupport::TestCase

  test "determines the correct number of boxes to use" do
    assert_equal ({"box_1"=>3}), shipping_requests(:order_one).number_of_boxes(shipping_requests(:order_one).number_of_items)
    assert_equal ({"box_1"=>5}), shipping_requests(:order_two).number_of_boxes(shipping_requests(:order_two).number_of_items)
    assert_equal ({"box_1"=>5, "box_2"=>3}), shipping_requests(:order_three).number_of_boxes(shipping_requests(:order_three).number_of_items)
  end

  test "determines the correct shipping weight for estimates" do
    request_one = shipping_requests(:order_one).number_of_boxes(shipping_requests(:order_one).number_of_items)
    request_two = shipping_requests(:order_two).number_of_boxes(shipping_requests(:order_two).number_of_items)
    request_three = shipping_requests(:order_three).number_of_boxes(shipping_requests(:order_three).number_of_items)

    assert_equal 144, shipping_requests(:order_one).weight(request_one["box_1"])
    assert_equal 240, shipping_requests(:order_two).weight(request_two["box_1"])
    assert_equal 384, (shipping_requests(:order_three).weight(request_three["box_1"]) + shipping_requests(:order_three).weight(request_three["box_2"]))
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

  test "order_id must be an integer" do
    one = shipping_requests(:order_one)
    one.order_id = 1.5

    refute one.valid?
    assert_includes one.errors.keys, :order_id
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

  test "number of items must be an integer" do
    one = shipping_requests(:order_one)
    one.number_of_items = 1.5

    refute one.valid?
    assert_includes one.errors.keys, :number_of_items
  end

  test "number of items must be greater than 0" do
    one = shipping_requests(:order_one)
    one.number_of_items = -2

    refute one.valid?
    assert_includes one.errors.keys, :number_of_items
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

  # due to the serializer in the model, we input a Hash and it's stored
  # in the database as a JSON string. when we get the value back out,
  # it's de-serialized from JSON into a Hash.
  test "estimates are given to ruby as a Hash from our model" do
    # request object here
    assert_instance_of Hash, shipping_requests(:order_one).estimates
  end

  test "get an ActiveShipping location object from origin for creating estimates" do
    result = shipping_requests(:order_one).origin
    expected_result = ActiveShipping::Location.new(country: "USA", zip: "98103")

    assert_instance_of ActiveShipping::Location, result
    assert_equal expected_result, result
    assert_equal expected_result.zip, result.zip
  end

  test "gets and ActiveShipping location object from destination for creating estimates" do
    result = shipping_requests(:order_one).destination
    expected_result = ActiveShipping::Location.new(country: "USA", zip: "98117")

    assert_instance_of ActiveShipping::Location, result
    assert_equal expected_result, result
    assert_equal expected_result.zip, result.zip
  end
end
