class AddAttachmentPhotoToCertificates < ActiveRecord::Migration
  def self.up
    change_table :certificates do |t|
      t.attachment :photo
    end
  end

  def self.down
    remove_attachment :certificates, :photo
  end
end
