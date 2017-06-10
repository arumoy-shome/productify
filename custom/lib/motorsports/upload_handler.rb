require 'shopify_api'
require 'dotenv/load'

module Motorsports
  class UploadHandler
    SHOP_URL = "https://#{ENV['SHOPIFY_API_KEY']}:#{ENV['SHOPIFY_API_PASSWORD']}" \
      "@613-motorsports.myshopify.com/admin"

    def self.upload_or_update_products
      ShopifyAPI::Base.site = SHOP_URL
    end
  end
end
