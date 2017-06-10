class AddIndexToProductsTimestamps < ActiveRecord::Migration[5.1]
  def change
    add_index(:products, :created_at)
    add_index(:products, :updated_at)
  end
end
