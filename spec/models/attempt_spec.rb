require 'rails_helper'

RSpec.describe Attempt, type: :model do
  it { should belong_to(:exercise) }
  it { should belong_to(:student_enroll) } 
end
