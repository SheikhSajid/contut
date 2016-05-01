class AddAttachmentProfilePictureToTutors < ActiveRecord::Migration
  def self.up
    change_table :tutors do |t|
      t.attachment :profile_picture
    end
  end

  def self.down
    remove_attachment :tutors, :profile_picture
  end
end
