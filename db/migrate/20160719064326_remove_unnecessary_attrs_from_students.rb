class RemoveUnnecessaryAttrsFromStudents < ActiveRecord::Migration
  # Removes email because it is conflicting with devise
  # Devise doesn not require password_digest
  def change
    remove_column :students, :email
    remove_column :students, :password_digest
  end
end
