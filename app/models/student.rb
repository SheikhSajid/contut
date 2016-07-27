class Student < ActiveRecord::Base
  before_save { self.first_name = first_name.capitalize }
  before_save { self.last_name = last_name.capitalize }
  
  validates :first_name,  presence: true, length: { maximum: 50 }
  validates :last_name,   presence: true, length: { maximum: 50 }
  validates :full_address,  presence: true
  validates :city,  presence: true
  validates :area,  presence: true
  validates :zip,  presence: true
  
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable,
         :lockable
    
    
  has_many :reviews,  dependent: :destroy
  has_many :messages, dependent: :destroy
  has_many :requests, dependent: :destroy
  has_many :tutors,   through:   :requests
  
  
  has_attached_file :profile_picture, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: "/images/:style/missing.png"
  validates_attachment_content_type :profile_picture, content_type: /\Aimage\/.*\Z/

end
