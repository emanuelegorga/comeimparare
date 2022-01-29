require 'rails_helper'

RSpec.describe User, type: :model do
  describe '#validations' do
    it { should have_many(:courses) }
    it { should validate_presence_of(:email) }
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:password_digest) }
    it { should validate_presence_of(:platform) }
  end
end