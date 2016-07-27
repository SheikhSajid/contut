class Accepted < ActiveRecord::Base
  # def self.already_accepted? (tutor_id, current_student_id)
  #   return !(where("tutor_id = ? AND student_id = ?", tutor_id, current_student_id).empty?)
  # end
  
  validates_uniqueness_of :student_id, :scope => :tutor_id
  
  belongs_to :tutor
  belongs_to :student
end
