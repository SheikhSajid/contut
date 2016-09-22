source 'https://rubygems.org'

gem 'rails', '4.2.6'
gem 'bootstrap-sass', '~> 3.3.6'
gem 'sass-rails', '~> 5.0'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.1.0'
gem 'jquery-rails'
gem 'turbolinks'
gem 'jbuilder', '~> 2.0'
gem 'sdoc', '~> 0.4.0', group: :doc
gem 'bcrypt', '~> 3.1.7'
gem 'paperclip', '~> 4.2.0'
gem 'devise'
gem 'omniauth-facebook'

# Use Unicorn as the app server
# gem 'unicorn'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development
group :test do
  gem 'simplecov', :require => false
  gem 'cucumber-rails', :require => false
  gem 'database_cleaner'
end

group :development, :test do
  gem 'byebug'
  gem 'sqlite3'
  gem 'rspec-rails', '~> 3.5'
  gem 'factory_girl_rails'
  gem 'capybara'
end

group :development do
  gem 'mailcatcher', '~> 0.6.1'
  gem 'web-console', '~> 2.0'
  gem 'spring'
end

group :production do
  gem 'pg' # for Heroku deployment
  gem 'rails_12factor'
end
