class Subject < ApplicationRecord
  belongs_to :s_class
  has_many :chapters, dependent: :destroy

  validates_presence_of :s_name
end
