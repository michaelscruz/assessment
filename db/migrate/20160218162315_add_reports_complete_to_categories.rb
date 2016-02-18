class AddReportsCompleteToCategories < ActiveRecord::Migration
  def up
    add_column :categories, :reports_complete, :boolean
    set_all_reports_complete_fields
  end

  def down
    remove_column :categories, :reports_complete 
  end

  def set_all_reports_complete_fields
    destroyed = 0
    Category.all.each do |category|
      if category.exam.nil?
        category.destroy
        puts "*** Destroyed category #{category.name} because it was not associated with an exam."
        destroyed += 1
      else
        if category.find_value_max == category.find_remaining_value_min
          category.reports_complete = true
          category.save!
          puts "Category #{category.name}'s reports marked as complete"
        else
          category.reports_complete = false
          puts "Category #{category.name}'s reports marked as INCOMPLETE"
        end
      end
    end
    puts "Number of categories destroyed: #{destroyed}"
  end
end
