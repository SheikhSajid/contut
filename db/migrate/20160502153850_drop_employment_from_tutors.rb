class DropEmploymentFromTutors < ActiveRecord::Migration
  def change
    remove_column :tutors, :curr_employer
    remove_column :tutors, :position
  end
end
