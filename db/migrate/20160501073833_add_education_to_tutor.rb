class AddEducationToTutor < ActiveRecord::Migration
  def change
    add_column :tutors, :degree, :string
    add_column :tutors, :institution, :string
    add_column :tutors, :year, :integer
  end
end
