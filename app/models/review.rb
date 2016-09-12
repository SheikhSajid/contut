class Review < ActiveRecord::Base
  belongs_to :student
  belongs_to :tutor
  
  validates :student_id,  presence: true
  validates :tutor_id,    presence: true
  validates :rating, numericality: { only_integer: true, greater_than_or_equal_to: 0, less_than_or_equal_to: 5 }
  validates_uniqueness_of :tutor_id, :scope => :student_id
end
