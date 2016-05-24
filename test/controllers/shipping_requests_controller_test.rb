require 'test_helper'

class ShippingRequestsControllerTest < ActionController::TestCase
  setup do
    #setting headers so we get JSON in return
    @request.headers['Accept'] = Mime::JSON
    @request.headers['Content-Type'] = Mime::JSON.to_s
    get :index
  end

  test "can get #index" do
    assert_response :success #Instead of :success you could also write 200-which means success
  end

  test "#index returns json" do
    assert_match 'application/json', response.header['Content-Type']
  end
end

class IndexJSONObject < ActionController::TestCase
  setup do
    @request.headers['Accept'] = Mime::JSON
    @request.headers['Content-Type'] = Mime::JSON.to_s

    get :index
    @body = JSON.parse(response.body)
  end

# determine the endpoint--figure out the outcome and build a test then create method
  test "returns an array of shipping estimates" do

    assert_instance_of Array, @body
    assert_equal Hash, @body.map(&:class).first
  end

  test "returns one object" do
    assert_equal 1, @body.length
  end

  test "each object contains the relevant keys" do
    keys = %w( chosen_type destination_zip estimates number_of_items order_id origin_zip tracking_info)
    assert_equal keys, @body.map(&:keys).flatten.uniq.sort
  end
end
#
# class ShowAction < ActionController::TestCase
#   setup do
#     @request.headers['Accept'] = Mime::JSON
#     @request.headers['Content-Type'] = Mime::JSON.to_s
#     get :show, id: pets(:rosa).id
#   end
#
#   test "can get #show" do
#     assert_response :success
#   end
#
#   test "#show returns json" do
#     assert_match 'application/json', response.header['Content-Type']
#   end
# end
#
# class ShowJSONObject < ActionController::TestCase
#   setup do
#     @request.headers['Accept'] = Mime::JSON
#     @request.headers['Content-Type'] = Mime::JSON.to_s
#
#     get :show, id: pets(:rosa).id #requires id parameter due to the route
#     @body = JSON.parse(response.body)
#     @keys = %w( age human id name )
#   end
#
#   test "has the right keys" do
#     assert_equal @keys, @body.keys.sort
#   end
#
#   test "has all of Rosa's info" do
#     @keys.each do |key|
#       assert_equal pets(:rosa)[key], @body[key]
#     end
#   end
# end
#
# class NoPetsFound < ActionController::TestCase
#   setup do
#     @request.headers['Accept'] = Mime::JSON
#     @request.headers['Content-Type'] = Mime::JSON.to_s
#
#     get :show, id: 1000
#     @body = JSON.parse(response.body)
#   end
#
#   test "no pet found is a 204 (no content)" do
#     assert_response 204
#   end
#
#   test "no pet found is an empty array" do
#     assert_equal [], @body
#   end
# end
