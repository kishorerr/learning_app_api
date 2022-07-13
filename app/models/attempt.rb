class Attempt < ApplicationRecord
  belongs_to :exercise
  belongs_to :student_enroll

  has_many :qn_responses, dependent: :destroy
end
