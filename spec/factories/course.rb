FactoryBot.define do
  factory :course do
    sequence(:title) { |n| 'Course example title' + " n. #{n}" }
    sequence(:description) { |n| 'Course example description' + " n. #{n}" }
    sequence(:price) { |n| '10' }
    language { 'english' }
    difficulty { 'easy' }
    association :user
  end
end 