FactoryBot.define do
  factory :user do
    sequence(:login) { |n| "emanuele #{n}" }
    name { 'Emanuele' }
    url { 'http://comeimparare.it' }
    avatar_url { 'http://comeimparare.it/avatar' }
    provider { 'local' }
    is_admin { false }
  end
end