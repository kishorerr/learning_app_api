class StudentEnroll < ApplicationRecord
    belongs_to :board, optional: true
    belongs_to :s_class, optional: true
    belongs_to :student, optional: true

    validates_presence_of :otp
    validates_presence_of :otp_generated_at
end
