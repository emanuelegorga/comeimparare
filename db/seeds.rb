user = User.first_or_create(
  email: 'admin@comeimparare.it',
  name: 'emanuele',
  password: 'password',
  password_confirmation: 'password',
  is_admin: true
)

10.times do 
  user.courses.create!(
    title: Faker::Movie.title, 
    description: Faker::Movie.quote,
    summary: Faker::TvShows::FamilyGuy.quote,
    price: Faker::Number.between(from: 1000, to: 30000),
    difficulty: rand(0..2),
    language: rand(0..3)
  )
end