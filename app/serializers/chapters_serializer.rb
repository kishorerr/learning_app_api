class ChaptersSerializer < ActiveModel::Serializer
  attributes :id, :c_name, :pdf_no , :video_no

  belongs_to :subject
  has_many :contents
  has_many :exercises
end
