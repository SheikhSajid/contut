class DropTutorSubjectsTable < ActiveRecord::Migration
  def up
    drop_table :tutors_subjects
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
