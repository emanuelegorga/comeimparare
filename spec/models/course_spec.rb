
require 'rails_helper'

RSpec.describe Course, type: :model do
  it 'should test that the factory is valid' do
    expect(FactoryBot.build :course).to be_valid
  end

  it 'should validate the presence of title' do
    course = FactoryBot.build :course, title: ''
    expect(course).not_to be_valid
    expect(course.errors.messages[:title]).to include("can't be blank")
  end

  it 'should validate the presence of description' do
    course = FactoryBot.build :course, description: ''
    expect(course).not_to be_valid
    expect(course.errors.messages[:description]).to include("can't be blank")
  end
end