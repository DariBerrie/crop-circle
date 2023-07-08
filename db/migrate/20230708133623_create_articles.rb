class CreateArticles < ActiveRecord::Migration[7.0]
  def change
    create_table :articles do |t|
      t.string :category
      t.string :author
      t.text :content
      t.datetime :date

      t.timestamps
    end
  end
end
