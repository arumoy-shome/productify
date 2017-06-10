$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)

require 'active_record'
require 'minitest/autorun'
require 'webmock/minitest'

ActiveRecord::Base.establish_connection(adapter: 'sqlite3', database: ':memory:')

load File.expand_path('test/support/schema.rb')

autoload :Product, 'support/product'
autoload :ProductVariant, 'support/product_variant'
