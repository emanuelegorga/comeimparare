def clean_db!
  Remark.destroy_all
  ProgressTrack.destroy_all
  Lecture.destroy_all
  Join.destroy_all
  Course.destroy_all
  User.destroy_all
end

clean_db!

User.create!([{
    email: 'admin@comeimparare.it',
    name: 'emanuele',
    password: 'password',
    password_confirmation: 'password'
  },
  {
    email: 'student@comeimparare.it',
    name: 'student',
    password: 'password',
    password_confirmation: 'password'
  }
])

admin = User.find_by(email: 'admin@comeimparare.it')
student = User.find_by(email: 'student@comeimparare.it')

10.times do
  course = admin.courses.create!(
    title: Faker::Movie.title, 
    description: Faker::Movie.quote,
    summary: Faker::TvShows::FamilyGuy.quote,
    price: Faker::Number.between(from: 1000, to: 30000),
    difficulty: rand(0..2),
    language: rand(0..3),
    accepted: true,
    published: true
  )
  course.logo.attach(io: File.open(File.join(Rails.root,'app/assets/images/sample.jpg')), filename: 'sample.jpg')
  student.join_course(course)
  student.rate_course(course, rand(1..5), Faker::TvShows::FamilyGuy.quote)
  lecture = course.lectures.create!(
    title: Faker::Movie.title,
    content: Faker::Lorem.paragraph
  )
  student.view_lecture(lecture)
  remark = lecture.remarks.create!(
    content: Faker::Lorem.paragraph,
    user: student
  )
end