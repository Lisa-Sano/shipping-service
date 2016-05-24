require 'test_helper'

class ShippingRequestTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  correctly identifies number of boxes needed for items
  correctly identifies weight of a shipment
  returns price estimates in form of carrier: price (as a hash)
   - carrier should be brand and type, example: UPS_Ground

  stores shipping requests

  ensures default zipcode is supplied if none provided for shipper

  give a weight get prices

  contains an order_id
  contains a destination zipcode
  contains a record of which ship type chosen
  contains a record of price of chosen ship type
  

end
