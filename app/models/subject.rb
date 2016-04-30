class Subject < ActiveRecord::Base
  # has_many :tutors, through: :tutors_subjects
  belongs_to :tutor
end
