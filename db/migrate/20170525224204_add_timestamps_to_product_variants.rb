class AddTimestampsToProductVariants < ActiveRecord::Migration[5.1]
  def change
    add_column :product_variants, :created_at, :datetime
    add_column :product_variants, :updated_at, :datetime
  end
end
