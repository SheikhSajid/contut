class TutorsTeachSubjects < ActiveRecord::Migration
  create_table :tutors_subjects, id: false do |t|
      t.integer :tutor_id
      t.integer :subject_id
  end
end
