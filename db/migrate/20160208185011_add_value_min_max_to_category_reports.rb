class AddValueMinMaxToCategoryReports < ActiveRecord::Migration
  def up
    add_column :category_reports, :value_min, :integer
    add_column :category_reports, :value_max_integer, :integer
    remove_column :category_reports, :value_key
  end

  def down
    remove_column :category_reports, :value_min
    remove_column :category_reports, :value_max
    add_column :category_reports, :value_key, :integer
  end
end
