class AddProPicToStudents < ActiveRecord::Migration
  def self.up
    change_table :students do |t|
      t.attachment :profile_picture
    end
  end

  def self.down
    remove_attachment :students, :profile_picture
  end
end
