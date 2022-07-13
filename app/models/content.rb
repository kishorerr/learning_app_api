class Content < ApplicationRecord
  belongs_to :chapter
  has_many :user_contents, dependent: :destroy

  validates_presence_of :link
  enum content_type: { video: 'video', pdf: 'pdf' }
  validates :content, inclusion: { in: content_types.keys }
end
