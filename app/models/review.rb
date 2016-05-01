class Review < ActiveRecord::Base
  belongs_to :student
  belongs_to :tutor
  
  validates_uniqueness_of :tutor_id, :scope => :student_id
end
