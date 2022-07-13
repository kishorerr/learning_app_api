class SubjectSerializer < ActiveModel::Serializer
  attributes :id, :s_name

  belongs_to :s_class
  has_many :chapters
end
