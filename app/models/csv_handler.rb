class CsvHandler
  BRANDS = ['HJC', 'ICON', 'ALPINESTARS', 'CARDO SYSTEMS'].freeze

  OPTIONS = {
    key_mapping: {
      part_number: :part_number,
      brand: :vendor,
      description_en: :title,
      dealer_price: :price,
      lon_qty_available: :inventory_quantity
    },
    remove_unmapped_keys: true
  }.freeze

  def self.parse(csv)
    SmarterCSV.process(csv, OPTIONS).select! do |product|
      BRANDS.include?(product[:vendor])
    end
  end
end
