require 'rails_helper'

RSpec.describe Student, type: :model do
  it { should have_one(:student_enroll)} 
end
