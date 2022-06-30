require 'rails_helper'

RSpec.describe SClass, type: :model do
  it { should have_many(:student_enrolls).dependent(:destroy) } 

  it { should validate_presence_of(:class_no) }
end
