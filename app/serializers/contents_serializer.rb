class ContentsSerializer < ActiveModel::Serializer
  attributes :id, :content, :link

  belongs_to :chapter
  has_many :user_contents
end
