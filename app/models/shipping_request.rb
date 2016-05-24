class ShippingRequest < ActiveRecord::Base

  # Box sides are measured in inches. Item weight is measured in oz.
  BOX_SIDE_DIMENSION = 12
  ITEM_WEIGHT_STANDARD = 48
  ITEMS_PER_BOX = 5


end
