class Subject < ApplicationRecord
  belongs_to :s_class
  belongs_to :board

  validates_presence_of :s_name
end
