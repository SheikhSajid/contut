class ChangePhoneToString < ActiveRecord::Migration
  def change
    change_column :tutors, :phone, :string
    change_column :students, :phone, :string
  end
end
