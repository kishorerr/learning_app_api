class StudentEnroll < ApplicationRecord
    belongs_to :board, optional: true
    belongs_to :s_class, optional: true
    belongs_to :student, optional: true
    has_many :user_contents, dependent: :destroy
    has_many :attempts, dependent: :destroy

    validates_presence_of :otp
    validates_presence_of :otp_generated_at
end
