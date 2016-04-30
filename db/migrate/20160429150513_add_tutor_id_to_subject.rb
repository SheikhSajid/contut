class AddTutorIdToSubject < ActiveRecord::Migration
  def change
    add_column :subjects, :tutor_id, :integer
  end
end
