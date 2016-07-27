class CreateRequests < ActiveRecord::Migration
  def change
    create_table :requests do |t|
      t.integer :tutor_id
      t.integer :student_id
      t.boolean :accepted

      t.timestamps null: false
    end
  end
end
