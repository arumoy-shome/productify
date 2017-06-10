require 'test_helper'

class ProductTest < ActiveSupport::TestCase
  def setup
    @product = Product.create!(part_number: 100,
                              title: 'A new product',
                              vendor: 'Icon')

    @variant = @product.variants.create!(inventory_quantity: 10,
                                         price: 100 )
  end

  test "new products have a part_number, title and vendor" do
    assert_equal 100, @product.part_number
    assert_equal 'A new product', @product.title
    assert_equal 'Icon', @product.vendor
    assert @product.save!
  end

  test "a product must have a title" do
    product = Product.new(vendor: 'Icon')

    refute product.save
  end

  test "a product must have a unique part_number" do
    product = Product.new(title: 'Chairs')

    refute product.save

    product.update(part_number: 200)

    new_product = Product.new(title: 'Tables', part_number: 200)

    refute new_product.save
  end

  test "product has variants" do
    assert_equal 10, @variant.inventory_quantity
    assert_equal 100, @variant.price
    assert_equal @product.id, @variant.product_id
    assert @variant.save!
  end

  test "product can have many variants" do
    create_variants

    assert_equal 4, @product.variants.length
  end

  test "product variants are dependent on their product" do
    create_variants

    variant_ids = @product.variants.pluck(:id)

    @product.destroy

    variant_ids.each do |id|
      refute @product.variants.exists?(id)
    end
  end

  test ".create_or_update_by creates a product if it doesn't exist" do
    new_products = [{ part_number: 200,
                      title: 'Helmet',
                      vendor: 'HJX',
                      inventory_quantity: 25,
                      price: 1000 },
                    { part_number: 300,
                      title: 'Gloves',
                      vendor: 'ICON',
                      inventory_quantity: 0,
                      price: 200 }]

    new_products.each do |attributes|
      Product.create_or_update_by(attributes)
    end

    new_products.each do |attributes|
      new_product = Product.find_by(part_number: attributes[:part_number])
      new_product_variant = new_product.variants.first

      assert new_product.persisted?
      assert new_product_variant.persisted?
      assert_equal attributes[:title], new_product.title
      assert_equal attributes[:vendor], new_product.vendor
      assert_equal attributes[:inventory_quantity], new_product_variant.inventory_quantity
      assert_equal attributes[:price], new_product_variant.price
    end
  end

  test "create_or_update_by updates a product if it already exists" do
    new_products = [{ part_number: 100,
                      title: 'A new title',
                      vendor: 'Icon',
                      inventory_quantity: 12,
                      price: 100 }]

    assert @product.persisted?
    assert @product.variants.first.persisted?
    assert_equal 'A new product', @product.title
    assert_equal 10, @product.variants.first.inventory_quantity

    new_products.each do |attributes|
      Product.create_or_update_by(attributes)
    end

    assert_equal 'A new title', Product.first.title
    assert_equal 12, Product.first.variants.first.inventory_quantity
  end

  private

  def create_variants
    (1..3).each do |num|
      @product.variants.create!(inventory_quantity: 10 + num,
                                price: 100 + num)
    end
  end
end
