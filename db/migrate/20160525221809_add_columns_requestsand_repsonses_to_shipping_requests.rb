class AddColumnsRequestsandRepsonsesToShippingRequests < ActiveRecord::Migration
  def change
    add_column :shipping_requests, :requests, :string
    add_column :shipping_requests, :responses, :string
  end
end
