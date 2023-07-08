class CreateTasks < ActiveRecord::Migration[7.0]
  def change
    create_table :tasks do |t|
      t.string :fieldOperationsType
      t.datetime :startDate
      t.datetime :endDate
      t.references :farm, null: false, foreign_key: true
      t.string :workStatus

      t.timestamps
    end
  end
end
