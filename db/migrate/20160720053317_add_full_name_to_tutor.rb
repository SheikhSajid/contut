class AddFullNameToTutor < ActiveRecord::Migration
  def change
    add_column :tutors, :name, :string
  end
end
