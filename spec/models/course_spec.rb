require 'rails_helper'

RSpec.describe Course, type: :model do
  it { should belong_to(:user) }
  it { should validate_presence_of(:title) }
  it { should validate_presence_of(:description) }
  it { should validate_presence_of(:difficulty) }
  it { should validate_presence_of(:language) }
  it { should validate_presence_of(:price) }
end