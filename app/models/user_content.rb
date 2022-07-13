class UserContent < ApplicationRecord
  belongs_to :content
  belongs_to :student_enroll

  enum status_type: { not_completed: 'not_started', started: 'started', completed: 'completed' }
  validates :status, inclusion: { in: status_types.keys }
end
