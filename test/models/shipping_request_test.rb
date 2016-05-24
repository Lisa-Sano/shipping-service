require 'test_helper'

class ShippingRequestTest < ActiveSupport::TestCase

  test "determines the correct number of boxes to use" do
    # set up order_one, shipping_requests[:order_two], order_three in  the fixtures

    assert_equal 1, shipping_requests[:order_one].number_of_boxes
    assert_equal 1, shipping_requests[:order_two].number_of_boxes
    assert_equal 2, shipping_requests[:order_three].number_of_boxes
  end

  test "determines the correct shipping weight for estimates" do
    assert_equal 144, shipping_requests[:order_one].weight
    assert_equal 240, shipping_requests[:order_two].weight
    assert_equal 384, shipping_requests[:order_three].weight
  end

  test "contains an order id" do
    refute_nil shipping_requests[:order_one].order_id
    refute_empty shipping_requests[:order_one].order_id
  end

  test "does not contain an order id invalidates request" do
    assert_raises(ArgumentError) { shipping_requests[:invalid_request].order_id }
  end

  test "contains a shipper zipcode" do
    refute_nil shipping_requests[:order_one].origin_zip
    assert_equal 5, shipping_requests[:order_one].origin_zip.length
  end

  test "uses 98103 as the zipcode for shipper if none is provided" do
    assert_equal 98103, shipping_requests[:order_one].origin_zip
  end

  test "does not contain a shipper zip invalidates request" do
    # write an invalid request here
    assert_raises(ArgumentError) { @invalid_request.origin_zip }
  end

  test "contains a destination zip" do
    refute_nil shipping_requests[:order_one].destination_zip
    assert_equal 5, shipping_requests[:order_one].destination_zip.length
  end

  test "does not contain a dest_zip invalidates request" do
    # write an invalid request here
    assert_raises(ArgumentError) { @invalid_request.destination_zip }
  end

  # test "when given an order, correctly derives number of boxes and weight" do
  #   # test object?
  #   
  # end

  # test "when given an order, after deriving weight and boxes, returns correct price estimates" do
    # write a test object here
    # assert_equal (estimate amount), testobject.estimates[key for which estimate we're checking]
    # assert_equal (second estimate amount), testobject.estimates[key for second estimate]
  # end

  test "when shipping request is finalized it contains a record of chosen ship type and price" do
    # write an API call for our API here to test saving
    # this test might need refactor

    # refute_nil @our_test_case.chosen_type
    # assert_includes(array_of_types), @our_test_case.chosen_type.keys

    # this needs to be refactored to specifically call the key used in this hash to identify shipper
    refute_nil shipping_requests[:order_one].chosen_type[shipper]
    refute_nil shipping_requests[:order_two].chosen_type[shipper]
  end

  test "when a shipping request is finalized it won't validate non-preferred shipper" do
    # write an API call to our API here for a bad request

    assert_raises(ArgumentError) {shipping_requests[:our_bad_request].chosen_type}
  end

  test "a valid shipping request saves on completion" do
    # write a request here.
    assert @our_request.valid?
    assert @our_request.save
  end

  test "an invalid request does not save on completion" do
    # write a bad request here
    refute @our_invalid_request.valid?
    refute @our_invalid_request.save
  end

  test "estimates are given to ruby as a hash" do
    # request object here
    assert_instance_of Hash, shipping_requests[:order_one].estimates
  end
end
