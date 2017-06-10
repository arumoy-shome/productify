require 'active_record'

module Motorsports
  ActiveRecord::Base.establish_connection(adapter: 'sqlite3', database: 'db/motorsports.db')

  load File.expand_path('support/schema.rb') unless File.exist?('db/motorsports.db')

  autoload :ArchiveHandler, 'motorsports/archive_handler'
  autoload :CsvHandler, 'motorsports/csv_handler'
  autoload :UploadHandler, 'motorsports/upload_handler'
  autoload :Product, 'motorsports/product'
end
