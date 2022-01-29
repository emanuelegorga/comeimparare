user = User.first_or_create(
  login: 'admin@comeimparare.it',
  name: 'emanuele',
  is_admin: true
)

10.times do 
  Course.create!(
    title: Faker::Movie.title, 
    description: Faker::Movie.quote,
    user_id: user.id
  )
end