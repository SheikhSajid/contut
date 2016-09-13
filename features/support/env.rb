require 'cucumber/rails'

Cucumber::Rails::Database.autorun_database_cleaner = false
Cucumber::Rails::World.use_transactional_fixtures = true
Capybara.default_selector = :css