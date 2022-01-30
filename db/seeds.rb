user = User.first_or_create(
  email: 'admin@comeimparare.it',
  name: 'emanuele',
  password: 'password',
  password_confirmation: 'password'
)

10.times do 
  course = user.courses.create!(
    title: Faker::Movie.title, 
    description: Faker::Movie.quote,
    summary: Faker::TvShows::FamilyGuy.quote,
    price: Faker::Number.between(from: 1000, to: 30000),
    difficulty: rand(0..2),
    language: rand(0..3)
  )
  course.logo.attach(io: File.open(File.join(Rails.root,'app/assets/images/sample.jpg')), filename: 'sample.jpg')
end

2.times do
  user.courses[0].lectures.create!(
    title: Faker::Movie.title,
    content: Faker::TvShows::FamilyGuy.quote
  )
end