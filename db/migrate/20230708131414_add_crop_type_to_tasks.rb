class AddCropTypeToTasks < ActiveRecord::Migration[7.0]
  def change
    add_column :tasks, :crop_type, :string
  end
end
