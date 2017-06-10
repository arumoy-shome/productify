module Motorsports
  class Product < ActiveRecord::Base
    has_many :variants, class_name: 'ProductVariant',
      foreign_key: 'product_id',
      dependent: :destroy

    def self.create_or_update_by(attributes)
      record = find_or_initialize_by(part_number: attributes[:part_number])

      record.update(part_number: attributes[:part_number],
                    title: attributes[:title],
                    vendor: attributes[:vendor])

      variant_attributes = attributes.select do |k, v|
        k == :inventory_quantity || k == :price
      end

      create_or_update_variant_by(record, variant_attributes)
      record.save
    end

    def self.create_or_update_variant_by(product, attributes)
      variant_record = product.variants.find_or_initialize_by(attributes)

      variant_record.update(inventory_quantity: attributes[:inventory_quantity],
                            price: attributes[:price])

      variant_record.save
    end
  end
end
