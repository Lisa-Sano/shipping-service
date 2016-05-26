class ShippingRequest < ActiveRecord::Base
  validates :origin_zip, :destination_zip, :number_of_items,  :estimates, :order_id, presence: true
  validates :destination_zip, length: { is: 5 }
  validates :number_of_items, numericality: { only_integer: true, greater_than: 0 }
  validates :order_id, numericality: { only_integer: true }

  serialize :estimates, JSON

  # Box sides are measured in inches. Item weight is measured in oz.
  BOX_SIDE_DIMENSION = 12
  ITEM_WEIGHT_STANDARD = 48
  ITEMS_PER_BOX = 5

  def package(order)
    # this will create the stuff we need to calculate what the package will cost.
    # multiply stuff from params by constants
  end

  def origin(order)
    # this will pull the origin/shipper zip
  end

  def destination(order)
    # this will pull the destination zip
  end

  def ups(order)
    # this will call the UPS API using package, origin, destination to get estimates.
  end

  def fedex(order)
    # this will call the FEDEX API using package, origin, destination to get estimates.
  end

  def assemble_estimates(shipper_zip, dest_zip, number_of_items)
    estimates = {}

    estimates[:ups] = ups(shipper_zip, dest_zip, package(number_of_items))
    estimates[:fedex] = fedex(shipper_zip, dest_zip, package(number_of_items))
  end

  def tracking(order)
    # this should be a way to retrieve a tracking number from shippers.
  end

  def number_of_boxes
    if number_of_items % ITEMS_PER_BOX != 0
      return (number_of_items / ITEMS_PER_BOX) + 1
    else
      return (number_of_items / ITEMS_PER_BOX)
    end
  end

  def weight
    return number_of_items * ITEM_WEIGHT_STANDARD
  end

end
