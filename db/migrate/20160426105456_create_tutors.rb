class CreateTutors < ActiveRecord::Migration
  def change
    create_table :tutors do |t|
      t.string :fname
      t.string :lname
      t.string :email
      t.string :gender
      t.integer :rate
      t.text :description
      t.string :city
      t.string :area
      t.integer :zip
      t.text :full_address

      t.timestamps null: false
    end
  end
end
