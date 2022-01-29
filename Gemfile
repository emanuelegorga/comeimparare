source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "3.1.0"

gem "rails", "~> 7.0.1"
gem "pg", "~> 1.1"
gem "puma", "~> 5.0"

# Use Redis adapter to run Action Cable in production
# gem "redis", "~> 4.0"

# Use Kredis to get higher-level data types in Redis [https://github.com/rails/kredis]
# gem "kredis"

gem "bcrypt", "~> 3.1.7"
gem "tzinfo-data", platforms: %i[ mingw mswin x64_mingw jruby ]
gem "bootsnap", require: false

# Use Active Storage variants [https://guides.rubyonrails.org/active_storage_overview.html#transforming-images]
# gem "image_processing", "~> 1.2"

gem "rack-cors"

gem 'jwt'

group :development, :test do
  gem "debug", platforms: %i[ mri mingw x64_mingw ]
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  gem 'pry'
  gem 'rubocop-rails'
  gem 'capybara', '>= 3.26'
  gem 'rspec-rails'
  gem 'faker'
end

group :test do
  gem 'rubocop-rspec', require: false
  gem 'factory_bot_rails', '~> 4.0'
  gem 'shoulda-matchers', '~> 3.1'
  gem 'database_cleaner', '~> 1.7.0'
end

