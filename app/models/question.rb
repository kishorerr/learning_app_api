class Question < ApplicationRecord
    belongs_to :exercise
    has_many :options, dependent: :destroy

    validates_presence_of :qn_no, :question, :duration, :solution
end
