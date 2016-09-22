class AddFacebookLoginToStudents < ActiveRecord::Migration
  def change
    add_column :students, :provider, :string
    add_column :students, :uid, :string
  end
end
