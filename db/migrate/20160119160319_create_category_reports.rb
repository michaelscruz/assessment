class CreateCategoryReports < ActiveRecord::Migration
  def change
    create_table :category_reports do |t|
      t.references :category, index: true
      t.text :text
      t.integer :value_key

      t.timestamps
    end
  end
end
