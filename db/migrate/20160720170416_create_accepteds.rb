class CreateAccepteds < ActiveRecord::Migration
  def change
    create_table :accepteds do |t|
      t.integer :tutor_id
      t.integer :student_id

      t.timestamps null: false
    end
  end
end
