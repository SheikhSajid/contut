class Student < ActiveRecord::Base
  before_save { self.first_name = first_name.capitalize }
  before_save { self.last_name = last_name.capitalize }
  
  validates :first_name,  presence: true, length: { maximum: 50 }
  validates :last_name,   presence: true, length: { maximum: 50 }
  validates :full_address,  presence: true
  # validates :city,  presence: true
  # validates :area,  presence: true
  # validates :zip,  presence: true
  
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable,
         :lockable, :omniauthable
    
    
  has_many :reviews,      dependent: :destroy
  has_many :messages,     dependent: :destroy
  has_many :requests,     dependent: :destroy
  has_many :requests,     dependent: :destroy
  has_many :accepteds,    dependent: :destroy
  has_many :pending_requests, through: :requests, source: :tutor
  has_many :accepted_tutors, through: :accepteds, source: :tutor
  
  
  has_attached_file :profile_picture, styles: { medium: "300x300>", thumb: "300x300>" }, default_url: "/images/:style/missing.png"
  validates_attachment_content_type :profile_picture, content_type: /\Aimage\/.*\Z/
  
  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0,6]
      user.first_name = auth.extra.raw_info.first_name
      user.last_name = auth.extra.raw_info.last_name
      user.gender = auth.extra.raw_info.gender
      # user.profile_picture = auth.info.image # assuming the user model has an image
      user.full_address = auth.extra.raw_info.location.name
      user.skip_confirmation!
    end
  end
  
  def self.new_with_session(params, session)
    if session["devise.facebook_data"]
      new(session["devise.facebook_data"], without_protection: true) do |student|
        student.attributes = params
        student.valid?
      end
    else
      super
    end
  end

  def confirmed_at
    Time.now
  end
end
