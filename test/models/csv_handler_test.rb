require 'test_helper'

class CsvHandlerTest < ActiveSupport::TestCase
  def setup
    @csv = CsvHandler.parse(csv_file)
  end

  test ".parse delegates to smarter csv with default options" do
    assert_kind_of Array, @csv
    assert_equal 13, @csv.length
  end

  test ".parse removes unnecessary columns and returns a new products object" do
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
      refute @csv.first.keys.include?(dropped_column)
    end
  end

  test ".parse only selects specified brands" do
    brands = @csv.map { |product| product[:vendor] }.uniq

    assert_equal ['HJC', 'ICON', 'ALPINESTARS', 'CARDO SYSTEMS'], brands
  end

  private

  def csv_file
    File.expand_path('test/example_zip/dealer.csv')
  end
end
