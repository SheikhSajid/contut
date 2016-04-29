class CreateReviews < ActiveRecord::Migration
  def change
    create_table :reviews do |t|
      t.text :comment
      t.integer :rating
      t.integer :tutor_id
      t.integer :student_id

      t.timestamps null: false
    end
  end
end
