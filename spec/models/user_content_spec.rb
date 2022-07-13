require 'rails_helper'

RSpec.describe UserContent, type: :model do
    it { should belong_to(:content) }
    it { should belong_to(:student_enroll) } 

end
