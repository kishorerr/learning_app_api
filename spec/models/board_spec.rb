require 'rails_helper'

RSpec.describe Board, type: :model do
  it { should have_many(:student_enrolls).dependent(:destroy) } 

  it { should validate_presence_of(:b_name) }
  it { should validate_presence_of(:b_desc) }
end
