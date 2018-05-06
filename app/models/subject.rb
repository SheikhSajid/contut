class Subject < ActiveRecord::Base
  # has_many :tutors, through: :tutors_subjects
  belongs_to :tutor
  
  def self.tutors_who_teach_this_subject(search_term)
    subject_tutors_found = []
    subjects = where("subjects.name LIKE ?", "%#{search_term}%").includes(:tutor)
    
    subjects.each do |s|
      subject_tutors_found << s.tutor
    end
    
    subject_tutors_found
  end
end
