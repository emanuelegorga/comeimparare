# Come Imparare - Online Course Side Project

<img width="1302" alt="readme-logo" src="https://user-images.githubusercontent.com/40179292/152701472-42b9226f-f1c8-48c2-9820-b8f4f469924d.png">

## This API powers the Live preview of a React UI.

### The API can be seen here: https://comeimparare.onrender.com/

The API is hosted on Render, a cloud platform that offers a free tier for web services.

If you are testing the API in production and see that the server is taking time to respond, please note that Render free web service tier spins down the instance whenever there is an activity for more than 15 minutes. It automatically spin back up when a new web request is received. This may take up to 30 seconds, however, following requests will be served immediately.

### The live can be seen here: https://comeimparare.netlify.app/

### React Frontend: https://github.com/emanuelegorga/comeimparare-frontend

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
cd comeimparare
bundle install
```

2. IMPORTANT You will need to set up the credentials in order to correctly run the application. The application uses Stripe API to process payments.

```
touch .env
```

Add the following credentials to the .env file:

```
STRIPE_PUBLISHABLE_KEY=your_stripe_publishable_key
STRIPE_SECRET_KEY=your_stripe_secret_key
AWS_ACCESS_KEY_ID=your_aws_access_key_id
AWS_SECRET_ACCESS_KEY=your_aws_secret_access_key
AWS_REGION=your_aws_region
AWS_BUCKET=your_aws_bucket
```

3. Run the database migrations and seed the database

```
rails db:create; rails db:migrate; rails db:seed;
```
