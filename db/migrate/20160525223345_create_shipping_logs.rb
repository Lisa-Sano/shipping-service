class CreateShippingLogs < ActiveRecord::Migration
  def change
    create_table :shipping_logs do |t|
      t.string :request
      t.string :response

      t.timestamps null: false
    end
  end
end
