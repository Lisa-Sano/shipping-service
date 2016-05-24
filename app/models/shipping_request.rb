class ShippingRequest < ActiveRecord::Base
  validates :origin_zip, :destination_zip, :number_of_items,  :estimates, :order_id, presence: true
  validates :destination_zip, length: { is: 5 }
  validates :number_of_items, numericality: { only_integer: true, greater_than: 0 }
  validates :order_id, uniqueness: true, numericality: { only_integer: true }

  # Box sides are measured in inches. Item weight is measured in oz.
  BOX_SIDE_DIMENSION = 12
  ITEM_WEIGHT_STANDARD = 48
  ITEMS_PER_BOX = 5

  def number_of_boxes(order_id)
    if (order_id.number_of_items % ITEMS_PER_BOX) != 0
      return (order_id.number_of_items / ITEMS_PER_BOX) + 1
    else
      return (order_id.number_of_items / ITEMS_PER_BOX)
    end
  end

  def weight(order_id)
    return order_id.number_of_items * ITEM_WEIGHT_STANDARD
  end

end
