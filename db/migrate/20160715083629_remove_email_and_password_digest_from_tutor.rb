class RemoveEmailAndPasswordDigestFromTutor < ActiveRecord::Migration
  # Removes email because it is conflicting with devise
  # Devise doesn not require password_digest
  def change
    remove_column :tutors, :email
    remove_column :tutors, :password_digest
  end
end
