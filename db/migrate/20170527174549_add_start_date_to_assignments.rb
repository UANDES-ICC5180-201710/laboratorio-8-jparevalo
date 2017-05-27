class AddStartDateToAssignments < ActiveRecord::Migration[5.0]
  def change
    add_column :assignments, :start_date, :date
  end
end
