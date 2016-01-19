class AddAccountIdToExams < ActiveRecord::Migration
  def change
    add_reference :exams, :account, index: true
  end
end
