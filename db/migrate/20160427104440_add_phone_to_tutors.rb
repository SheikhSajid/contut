class AddPhoneToTutors < ActiveRecord::Migration
  def change
    add_column :tutors, :phone, :integer
  end
end
