class CreateStudents < ActiveRecord::Migration
  def change
    create_table :students do |t|
      t.string  :first_name
      t.string  :last_name
      t.string  :email
      t.integer :phone
      t.string  :city
      t.string  :area
      t.integer :zip
      t.text    :full_address

      t.timestamps null: false
    end
  end
end
