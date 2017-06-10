require 'zip'

module Motorsports
  class ArchiveHandler
    NEW_FILE = File.expand_path('tmp/canada_parts_data.new.csv')

    def self.unarchive(archive)
      File.delete(NEW_FILE) if File.exist?(NEW_FILE)

      Zip::File.open(archive) do |files|
        if file = files.glob('*.csv').first
          file.extract(NEW_FILE)
        end
      end
    end
  end
end
