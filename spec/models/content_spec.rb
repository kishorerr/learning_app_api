require 'rails_helper'

RSpec.describe Content, type: :model do
  it { should belong_to(:chapter) }

  it { should validate_presence_of(:link) }
end
