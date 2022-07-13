class OptionSerializer < ActiveModel::Serializer
  attributes :id

  belongs_to :question
end
