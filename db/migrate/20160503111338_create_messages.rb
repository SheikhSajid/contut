class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.integer :tutor_id
      t.integer :student_id
      t.text :message

      t.timestamps null: false
    end
  end
end
