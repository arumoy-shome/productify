require 'dotenv/load'

class UploadHandler
  def self.call
    ShopifyAPI::Base.site = SHOP_URL

    Product.created_or_updated_today.find_each do |product|
      product_attributes = product
        .attributes
        .reject { |k, v| REJECTED_ATTRIBUTES.include?(k) }

      variant_attributes = product
        .variants
        .first
        .attributes
        .reject { |k, v| REJECTED_ATTRIBUTES.include?(k) }
        .merge(inventory_management: 'shopify')

      attributes = product_attributes.merge(variants: [variant_attributes])

      if product.created_at > Time.current.beginning_of_day
        response = ShopifyAPI::Product.create(attributes)
      end

      if product.updated_at > Time.current.beginning_of_day
        # TODO: Not Implemented
      end
    end
  end
end
