require 'test_helper'
require 'motorsports'

class CsvHandlerTest < Minitest::Test
  def test_parse_delegates_to_smarter_csv_with_default_options
    csv = Motorsports::CsvHandler.parse(csv_file)

    assert_kind_of Array, csv
    assert_equal 13, csv.length
  end

  def test_parse_removes_unnecessary_columns_and_returns_a_new_products_object
    csv = Motorsports::CsvHandler.parse(csv_file)

    columns = %i[part_number
                 brand
                 description_en
                 dealer_price
                 lon_qty_availabl]

    dropped_columns = SmarterCSV.process(csv_file)
      .first
      .keys
      .reject { |key| columns.include?(key) }

    dropped_columns.each do |dropped_column|
      refute csv.first.keys.include?(dropped_column)
    end
  end

  def test_parse_only_selects_specified_brands
    csv = Motorsports::CsvHandler.parse(csv_file)

    brands = csv.map { |product| product[:vendor] }.uniq

    assert_equal ['HJC', 'ICON', 'ALPINESTARS', 'CARDO SYSTEMS'], brands
  end

  private

  def csv_file
    File.expand_path('test/example_zip/dealer.csv')
  end
end
