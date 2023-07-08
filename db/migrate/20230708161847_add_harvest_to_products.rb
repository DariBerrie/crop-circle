class AddHarvestToProducts < ActiveRecord::Migration[7.0]
  def change
    add_column :products, :harvest, :integer
    add_column :products, :harvested_at, :datetime
  end
end
