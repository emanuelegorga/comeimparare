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
    price: 10,
    difficulty: 'easy',
    language: 'english'
  )
end