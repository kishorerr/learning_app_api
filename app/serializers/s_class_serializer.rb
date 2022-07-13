class SClassSerializer < ActiveModel::Serializer
  attributes :id, :class_no

  has_many :subjects
  has_many :student_enrolls

  belongs_to :board
end
