class AddEndDateToAssignments < ActiveRecord::Migration[5.0]
  def change
    add_column :assignments, :end_date, :date
  end
end
