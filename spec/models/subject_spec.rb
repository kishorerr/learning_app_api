require 'rails_helper'

RSpec.describe Subject, type: :model do
  it { should belong_to(:board) }
  it { should belong_to(:s_class) } 

  it { should validate_presence_of(:s_name) }
end
