class Board < ApplicationRecord
    has_many :student_enrolls, dependent: :destroy
    has_many :s_classes, dependent: :destroy
    
    validates_presence_of :b_name, :b_desc
end
