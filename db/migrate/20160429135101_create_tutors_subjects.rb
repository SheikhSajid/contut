class CreateTutorsSubjects < ActiveRecord::Migration
  def change
    create_table :tutors_subjects do |t|
      t.integer :tutor_id
      t.integer :subject_id

      t.timestamps null: false
    end
  end
end
