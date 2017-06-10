class Product < ApplicationRecord
  has_many(:variants, class_name: 'ProductVariant',
           dependent: :destroy)

  validates_presence_of :title
  validates_presence_of :part_number
  validates_uniqueness_of :part_number

  def self.created_or_updated_today
    where("created_at > ? OR updated_at > ?",
          Time.current.beginning_of_day,
          Time.current.beginning_of_day)
  end

  def self.create_or_update_by(attributes)
    record_attributes = attributes.reject do |k, v|
      k == :inventory_quantity || k == :price
    end

    variant_attributes = attributes.select do |k, v|
      k == :inventory_quantity || k == :price
    end

    record = find_or_initialize_by(part_number: record_attributes[:part_number])

    record.update(record_attributes)

    create_or_update_variant_by(record, variant_attributes)
  end

  def self.create_or_update_variant_by(product, attributes)
    if record = product.variants.first
      record.update(attributes)
    else
      product.variants.create(attributes)
    end
  end
end
