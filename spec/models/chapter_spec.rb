require 'rails_helper'

RSpec.describe Chapter, type: :model do
  it { should belong_to(:subject) }

  it { should validate_presence_of(:c_name) }
  it { should validate_presence_of(:pdf_no) }
  it { should validate_presence_of(:video_no) }
end
