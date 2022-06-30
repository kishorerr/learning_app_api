class SClass < ApplicationRecord
  has_many :student_enrolls, dependent: :destroy
  validates_presence_of :class_no
end
