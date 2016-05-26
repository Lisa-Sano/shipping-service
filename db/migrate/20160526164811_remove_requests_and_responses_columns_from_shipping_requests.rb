class RemoveRequestsAndResponsesColumnsFromShippingRequests < ActiveRecord::Migration
  def change
    remove_column :shipping_requests, :requests
    remove_column :shipping_requests, :responses
  end
end
