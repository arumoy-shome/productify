ActiveRecord::Schema.define do
  self.verbose = false

  create_table(:products, force: true) do |t|
    t.integer :part_number
    t.string :vendor
    t.string :title
  end

  create_table(:product_variants, force: true) do |t|
    t.references :product, index: true
    t.integer :inventory_quantity
    t.float :price
  end
end
