source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "2.7.1"

gem "rails", "~> 6.1.4", ">= 6.1.4.1"
gem "pg", "~> 1.1"
gem "puma", "~> 5.0"
gem "sass-rails", ">= 6"
gem "webpacker", "~> 5.0"
gem "turbolinks", "~> 5"
gem "jbuilder", "~> 2.7"
gem "bootsnap", ">= 1.4.4", require: false
gem "devise"
gem "pundit"
gem "shrine", "~> 3.0"
gem "image_processing", "1.9.3"
gem "mini_magick", "4.9.5"

group :development, :test do
  gem "byebug", platforms: [:mri, :mingw, :x64_mingw]
  gem "letter_opener"
end

group :development do
  gem "web-console", ">= 4.1.0"
  gem "rack-mini-profiler", "~> 2.0"
  gem "listen", "~> 3.3"
  gem "spring"
end

group :test do
  gem "selenium-webdriver"
  gem "webdrivers"
  gem "rspec-rails"
  gem "capybara"
  gem "database_cleaner"
  gem "factory_bot_rails"
  gem "faker"
end

gem "tzinfo-data", platforms: [:mingw, :mswin, :x64_mingw, :jruby]
