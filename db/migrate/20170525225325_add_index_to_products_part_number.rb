class AddIndexToProductsPartNumber < ActiveRecord::Migration[5.1]
  def change
    add_index(:products, :part_number, unique: true)
  end
end
