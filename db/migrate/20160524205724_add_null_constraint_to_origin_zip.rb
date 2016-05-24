class AddNullConstraintToOriginZip < ActiveRecord::Migration
  def change
    change_column :shipping_requests, :origin_zip, :string, :default => "98103", null: false
  end
end
