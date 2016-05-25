class AddCountryColumnToShippingRequests < ActiveRecord::Migration
  def change
    add_column :shipping_requests, :country, :string, :default => "USA", null: false
  end
end
