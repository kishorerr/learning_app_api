class QuestionSerializer < ActiveModel::Serializer
  attributes :id, :qn_no, :question

  belongs_to :exercise
  has_many :options
end
