class QnResponse < ApplicationRecord
  belongs_to :question
  belongs_to :attempt
end
