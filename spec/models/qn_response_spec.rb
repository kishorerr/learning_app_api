require 'rails_helper'

RSpec.describe QnResponse, type: :model do
  it { should belong_to(:question) }
  it { should belong_to(:attempt) } 
end
