require 'test_helper'

class ProductTest < Minitest::Test
  def setup
    @product = Product.create!(part_number: 100,
                               title: 'a new product',
                               vendor: 'Icon')

    @variant = @product.variants.new(inventory_quantity: 12,
                                     price: 120)
  end

  def test_product_can_create_products
    assert @product
    assert_equal 100, @product.part_number
    assert_equal 'a new product', @product.title
    assert_equal 'Icon', @product.vendor
    assert @product.save!
  end

  def test_product_can_create_variants
    assert_equal 12, @variant.inventory_quantity
    assert_equal 120, @variant.price
    assert_equal @product.id, @variant.product_id
    assert @variant.save!
  end

  def test_product_can_have_multiple_variants
    create_variants

    assert_equal 4, @product.variants.length
  end

  def test_product_variants_are_dependent_on_their_product
    create_variants

    variant_ids = @product.variants.pluck(:id)

    @product.destroy

    variant_ids.each do |id|
      refute @product.variants.exists?(id)
    end
  end

  def test_create_or_update_by_creates_a_product_if_it_does_not_exist
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

    new_products.each do |attributes|
      new_product = Product.find_by(part_number: attributes[:part_number],
                                    title: attributes[:title],
                                    vendor: attributes[:vendor])

      assert new_product.variants.exists?(inventory_quantity: attributes[:inventory_quantity],
                                          price: attributes[:price])
      assert new_product
    end
  end

  def test_create_or_update_by_updates_a_product_if_it_already_exists
    new_products = [{ part_number: 100,
                      title: 'a new product',
                      vendor: 'Icon',
                      inventory_quantity: 12,
                      price: 100 }]


    new_products.each do |attributes|
      Product.create_or_update_by(attributes)
    end

    assert_equal 12, @product.variants.first.inventory_quantity
  end

  private

  def create_variants
    (1..3).each do |num|
      @product.variants.create!(inventory_quantity: 10 + num,
                                price: 100 + num)
    end
  end
end
