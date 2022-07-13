class BoardSerializer < ActiveModel::Serializer
  attributes :id, :b_name, :b_desc

  has_many :s_classes
  has_many :student_enrolls
end
