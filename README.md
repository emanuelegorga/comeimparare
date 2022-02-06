# Come Imparare - Online Course Side Project

<img width="1302" alt="readme-logo" src="https://user-images.githubusercontent.com/40179292/152701472-42b9226f-f1c8-48c2-9820-b8f4f469924d.png">

## This API powers the Live preview of a React UI.

### The live can be seen here: https://comeimparare.herokuapp.com/

### React Frontend: https://github.com/emanuelegorga/comeimparare-frontend

### Introduction to the API

The API is built with Ruby On Rails following the RESTful API standards. Users are authenticated via JWT tokens.

The database is formed by the following tables:

- User -> a user can have different roles such as Admin, Teacher and Student
- Course -> an user can create courses to sell or buy courses from other teachers to learn from
- Lecture -> a course can have many lectures
- Join -> join table between courses and users
- ProgressTrack -> keeps track of the lectures that an user sees
- Remark -> comments that can be left on lectures
- Role -> roles that an user can have
- UserRole -> join table between users and roles
- Order -> when an user buys a course, an order is created

### Main gems that have been used:

- JWT
- AWS-SDK-S3
- STRIPE
- ROLIFY
- PUNDIT
- MONEY
- FAKER
- RANSACK
- WILL_PAGINATE
- ACTIVE_MODEL_SERIALIZERS
- RSPEC
- FACTORY-BOT

### Environment

- Ruby v 3.1.0 +
- Rails 7.0.1 +
- PostgreSQL DB

### External APIs

- AWS S3 Buckets
- Stripe API

### 2. Setup the App

1. Clone the Rails application in your local environment

```
git clone git@github.com:emanuelegorga/comeimparare.git
cd golearn
bundle install
```

2. IMPORTANT You will need to set up the credentials in order to correctly run the application. The application uses Stripe API to process payments.

```
EDITOR="vim" rails credentials:edit --environment development
EDITOR="vim" rails credentials:edit --environment production
```

<img width="317" alt="credentials" src="https://user-images.githubusercontent.com/40179292/152700947-602502b8-d39d-43b6-83b1-9935c25e1007.png">

3. Run the database migrations

```
rails db:create; rails db:migrate; rails db:seed;
```
