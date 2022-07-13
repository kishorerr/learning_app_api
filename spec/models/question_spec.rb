require 'rails_helper'

RSpec.describe Question, type: :model do
  it { should belong_to(:exercise) }
end
