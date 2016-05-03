class Message < ActiveRecord::Base
  belongs_to :student
  belongs_to :tutor
end
