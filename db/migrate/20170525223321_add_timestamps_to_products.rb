class AddTimestampsToProducts < ActiveRecord::Migration[5.1]
  def change
    add_column(:products, :created_at, :datetime)
    add_column(:products, :updated_at, :datetime)
  end
end
