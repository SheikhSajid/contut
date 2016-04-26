class AddPasswordDigestToTutors < ActiveRecord::Migration
  def change
    add_column :tutors, :password_digest, :string
  end
end
