FactoryBot.define do
  factory :user do
    sequence(:email) { |n| "emanuele#{n}@comeimparo.it" }
    name { 'Emanuele' }
    password { 'password' }
    avatar_url { 'http://comeimparare.it/avatar' }
    platform { 'local' }
  end
end
