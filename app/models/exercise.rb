class Exercise < ApplicationRecord
  belongs_to :chapter

  has_many :attempts, dependent: :destroy
  has_many :questions, dependent: :destroy

  validates_presence_of :title, :duration, :qn_no, :instructions
end
