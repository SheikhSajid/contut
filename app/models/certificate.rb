class Certificate < ActiveRecord::Base
  belongs_to :tutor
  
  has_attached_file :photo, styles: { large: "600x600>" }
  validates_attachment_content_type :photo, content_type: /\Aimage\/.*\Z/
end
