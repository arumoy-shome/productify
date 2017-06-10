require 'test_helper'

class UploadHandlerTest < ActiveSupport::TestCase
  test "call retrieves products that were created or modified the same day" do
    excluded_product_part_number = 200
    create_new_products

    retrieved_records = UploadHandler.call

    assert_equal 3, retrieved_records.count
    refute retrieved_records.pluck(:part_number).include?(excluded_product_part_number)
  end

  test "call posts new products to the store" do

    create_new_products
    # TODO: There are not assertions here

    # excluded_product_part_numbers = [200, 300]

    posted_products = UploadHandler.call

    # assert_equal 2, posted_products.count
    # excluded_product_part_numbers.each do |part_number|
    #   refute posted_products.pluck(:part_number).include?(part_number)
    # end

  end

  private

  def create_new_products
    new_products = [{ part_number: 200,
                      title: 'Helmet',
                      vendor: 'HJX',
                      inventory_quantity: 25,
                      price: 1000,
                      created_at: Time.current.beginning_of_day - 3.days,
                      updated_at: Time.current.beginning_of_day - 3.days },
                    { part_number: 300,
                      title: 'Gloves',
                      vendor: 'ICON',
                      inventory_quantity: 0,
                      price: 200,
                      created_at: Time.current.beginning_of_day - 3.days,
                      updated_at: Time.current.beginning_of_day + 6.hours },
                    { part_number: 400,
                      title: 'Sinks',
                      vendor: 'Ikea',
                      inventory_quantity: 50,
                      price: 600,
                      created_at: Time.current.beginning_of_day + 6.hours,
                      updated_at: Time.current.beginning_of_day - 3.days },
                    { part_number: 500,
                      title: 'Bars',
                      vendor: 'Snickers',
                      inventory_quantity: 1000,
                      price: 5 }]


    new_products.each do |attributes|
      Product.create_or_update_by(attributes)
    end
  end
end
