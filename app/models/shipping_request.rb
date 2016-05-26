require 'active_shipping'

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

  def package(number_of_items)
    # package = ActiveShipping::Package.new(16, [12, 12, 12], units: :imperial)
    # 16 is the weight
    # array is box dimensions


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

  def number_of_boxes(number_of_items)
    boxes = {}
    counter = 0

    until number_of_items < 5
      counter += 1
      boxes["box_#{counter}"] = 5
      number_of_items -= 5
    end

    boxes["box_#{counter + 1}"] = number_of_items

    return boxes
  end

  def weight(items_in_box)
    return items_in_box * ITEM_WEIGHT_STANDARD
  end

end
