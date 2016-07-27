class ChangeNameInTutor < ActiveRecord::Migration
  def change
    change_column :tutors, :name, :string, :null => false
  end
end
