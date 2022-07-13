class ExercisesSerializer < ActiveModel::Serializer
  attributes :id

  belongs_to :chapter
  has_many :questions
end
