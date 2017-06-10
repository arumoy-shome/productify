require 'test_helper'
require 'motorsports'

class UploadHandler < Minitest::Test
  def test_upload_handler_create_posts_new_products_created_that_day
    new_products = [{ part_number: 200,
                      title: 'a new product',
                      vendor: 'Icon',
                      inventory_quantity: 10,
                      price: 100 },
                      { part_number: 300,
                        title: 'another new product',
                        vendor: 'HJC',
                        inventory_quantity: 0,
                        price: 200 }]

    new_products.each do |attributes|
      Product.create_or_update_by(attributes)
    end

    response = Motorsports::UploadHandler.upload_or_update_products

    assert 2, response.count
    assert response.errors.details.empty?
  end
end
