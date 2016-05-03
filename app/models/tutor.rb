class Tutor < ActiveRecord::Base
    before_save { self.email = email.downcase }
    before_save { self.fname = fname.capitalize }
    before_save { self.lname = lname.capitalize }
    
    validates :fname,  presence: true, length: { maximum: 50 }
    validates :lname,  presence: true, length: { maximum: 50 }
    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
    validates :email, presence: true, length: { maximum: 255 },
                    uniqueness: { case_sensitive: false },
                    format: { with: VALID_EMAIL_REGEX }
    has_secure_password
    validates :password, length: { minimum: 6 }
    
    has_many :reviews
    has_many :subjects, dependent: :destroy
    has_many :messages, dependent: :destroy
    # has_many :students, through: :messages
    
    has_attached_file :profile_picture, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: "/images/:style/missing.png"
    validates_attachment_content_type :profile_picture, content_type: /\Aimage\/.*\Z/
end
