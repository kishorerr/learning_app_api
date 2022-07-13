class Chapter < ApplicationRecord
  belongs_to :subject
  has_many :contents, dependent: :destroy
  has_many :exercises, dependent: :destroy

  validates_presence_of :c_name, :pdf_no, :video_no
end
