class Option < ApplicationRecord
  belongs_to :question

  validates_presence_of :option_name, :option
  enum opt_type: { correct: 'correct', wrong: 'wrong' }
  validates :opt_status, inclusion: { in: opt_types.keys }
end
