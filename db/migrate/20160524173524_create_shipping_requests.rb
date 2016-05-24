class CreateShippingRequests < ActiveRecord::Migration
  def change
    create_table :shipping_requests do |t|

      t.string    "origin_zip", :default => "98103"
      t.string    "destination_zip", null: false
      t.integer   "number_of_items", null: false
      t.string    "estimates", null: false
      t.string    "chosen_type"
      t.string    "tracking_info"
      t.integer   "order_id", null: false


      t.timestamps null: false
    end
  end
end
