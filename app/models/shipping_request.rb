class ShippingRequest < ActiveRecord::Base
validates :origin_zip, :destination_zip, :number_of_items,  :estimates, :order_id, presence: true
validates :destination_zip, length: { is: 5 }
validates :number_of_items, numericality: { only_integer: true, greater_than: 0 }
validates :order_id, uniqueness: true, numericality: { only_integer: true }

  # Box sides are measured in inches. Item weight is measured in oz.
  BOX_SIDE_DIMENSION = 12
  ITEM_WEIGHT_STANDARD = 48
  ITEMS_PER_BOX = 5

end
