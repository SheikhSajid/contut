class Tutor < ActiveRecord::Base
  before_save { self.name = name.titleize }
  validates :name,          presence: true, length: { maximum: 50 }
  validates :rate,          presence: true
  validates :full_address,  presence: true
  validates :city,          presence: true
  validates :area,          presence: true
  validates :zip,           presence: true
  validates :degree,        presence: true
  validates :institution,   presence: true
  validates :year,          presence: true
  
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable,
         :lockable
         
  # Associations
  has_many :reviews,   dependent: :destroy
  has_many :subjects,  dependent: :destroy
  has_many :messages,  dependent: :destroy
  has_many :articles,  dependent: :destroy
  has_many :requests,  dependent: :destroy
  has_many :accepteds, dependent: :destroy
  has_many :student_requests,  through: :requests,  source: :student
  has_many :accepted_students, through: :accepteds, source: :student
  
  # Paperclip gem
  has_attached_file :profile_picture, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: "/images/:style/missing.png"
  validates_attachment_content_type :profile_picture, content_type: /\Aimage\/.*\Z/
  
end
