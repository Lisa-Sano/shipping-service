class ChangeChosenTypeToRequest < ActiveRecord::Migration
  def change
    rename_column :shipping_requests, :chosen_type, :request
  end
end
