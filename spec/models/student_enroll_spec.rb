require 'rails_helper'

RSpec.describe StudentEnroll, type: :model do
  it { should belong_to(:board) } 
  it { should belong_to(:s_class) }
  it { should belong_to(:student) } 

  it { should have_many(:user_contents).dependent(:destroy) }
  it { should have_many(:attempts).dependent(:destroy) }

  it { should validate_presence_of(:otp) }
  it { should validate_presence_of(:otp_generated_at) }
end
