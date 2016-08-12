class AddApprovedColumnToTutor < ActiveRecord::Migration
  def change
    add_column :tutors, :approved, :boolean, default: false
  end
end
