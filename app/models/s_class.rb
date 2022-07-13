class SClass < ApplicationRecord
  belongs_to :board

  has_many :student_enrolls, dependent: :destroy
  has_many :subjects, dependent: :destroy
  
  validates_presence_of :class_no
end
