class AddInstitutionToStudents < ActiveRecord::Migration
  def change
    add_column :students, :institution, :string
  end
end
