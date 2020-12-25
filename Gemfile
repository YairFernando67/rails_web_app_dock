source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.6.2'

gem 'rails', '~> 6.1.0'
gem 'pg', '~> 1.1'
gem 'puma', '~> 5.0'
gem 'sass-rails', '>= 6'
gem 'webpacker', '~> 5.0'
gem 'turbolinks', '~> 5'
gem 'jbuilder', '~> 2.7'

gem 'bootsnap', '>= 1.4.4', require: false

group :development, :test do  
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  gem 'awesome_print'
  gem 'pry-byebug'
  gem 'dotenv-rails'
  gem "pry-rails"
  gem "rspec-rails"
end

group :development do  
  gem 'web-console', '>= 4.1.0'    
  gem 'rack-mini-profiler', '~> 2.0'
  gem 'listen', '~> 3.3'  
  gem 'spring'
end

group :test do  
  gem 'capybara', '>= 3.26'
  gem 'selenium-webdriver'  
  gem 'webdrivers'
  gem "database_cleaner", "~> 1.6.0"
  gem "factory_bot_rails"
  gem "faker"
  gem 'shoulda'
  gem 'shoulda-matchers'
end

gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
