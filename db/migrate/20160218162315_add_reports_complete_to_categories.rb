class AddReportsCompleteToCategories < ActiveRecord::Migration
  def change
    add_column :categories, :reports_complete, :boolean
  end
end
