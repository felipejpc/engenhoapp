# frozen_string_literal: true

source "https://rubygems.org"
git_source(:github) {|repo| "https://github.com/#{repo}.git" }

ruby "2.6.3"

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem "rails", "~> 6.0.2", ">= 6.0.2.1"
# Use postgresql as the database for Active Record
gem "pg"
# Use Puma as the app server
gem "puma", "~> 4.1"
# Use SCSS for stylesheets
gem "sass-rails", ">= 6"
# Transpile app-like JavaScript. Read more: https://github.com/rails/webpacker
# gem 'webpacker', '~> 4.0'
# Turbolinks makes navigating your web application faster. Read more: https://github.com/turbolinks/turbolinks
gem "turbolinks", "~> 5"
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem "jbuilder", "~> 2.7"
# A Scope & Engine based, clean, powerful, customizable and sophisticated paginator
gem 'kaminari'
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 4.0'
# Use Active Model has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Active Storage variant
# gem 'image_processing', '~> 1.2'

# Reduces boot times through caching; required in config/boot.rb
gem "bootsnap", ">= 1.4.2", require: false

# Platform to control content from a single hub and CMS.
gem "contentful"
gem "rich_text_renderer"
# Quickly create a share feature in you Rails apps. https://github.com/huacnlee/social-share-button
gem "social-share-button"

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem "byebug", platforms: %i[mri mingw x64_mingw]
  # Runtime developer console
  gem "pry", "~> 0.12.2"
  gem 'pry-rails'
  gem 'pry-doc'
  # Adds step-by-step debugging and stack navigation capabilities to pry using byebug.
  gem "pry-byebug"
  # Static code analyzer and code formatter. Out of the box it will enforce many of the guidelines outlined in the
  # community Ruby Style Guide.
  gem "rubocop", require: false
  # A RuboCop extension focused on enforcing Ruby and Rails best practices and coding conventions.
  gem "rubocop-rails", require: false
  # Ruby library that pretty prints Ruby objects in full color exposing their internal structure with proper indentation
  gem 'awesome_print'
end

group :development do
  # Access an interactive console on exception pages or by calling 'console' anywhere in the code.
  gem "listen", ">= 3.0.5", "< 3.2"
  gem "web-console", ">= 3.3.0"
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem "spring"
  gem "spring-watcher-listen", "~> 2.0.0"
end

group :test do
  # Adds support for Capybara system testing and selenium driver
  gem "capybara", ">= 2.15"
  gem "selenium-webdriver"
  # Easy installation and use of web drivers to run system tests with browsers
  gem "webdrivers"
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem "tzinfo-data", platforms: %i[mingw mswin x64_mingw jruby]
