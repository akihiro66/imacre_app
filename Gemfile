source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.6.6'

gem 'rails', '~> 6.0.3', '>= 6.0.3.3'
gem 'pg', '>= 0.18', '< 2.0'
gem 'puma', '~> 4.1'
gem 'sass-rails', '>= 6'
gem 'webpacker', '~> 4.0'
gem 'turbolinks', '~> 5'
gem 'jbuilder', '~> 2.7'
gem 'bootsnap', '>= 1.4.2', require: false

# ログイン機能
gem 'devise'

gem 'bootstrap-sass'
# ダミーデータの生成
gem 'faker'
# ページネーション
gem 'will_paginate', '3.1.8'
gem 'will_paginate-bootstrap4'
# 画像投稿機能
gem 'carrierwave', '~> 2.0'
gem 'fog-aws'
# 画像リサイズ機能
gem "mini_magick"
# 検索機能
gem 'ransack'

group :development, :test do
  gem 'rspec-rails'
  gem 'rails-controller-testing'
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  gem 'rubocop-airbnb'
  # モデルに関するテストデータ作成用
  gem 'factory_bot_rails'
end

group :production do
 gem 'fog'
end

group :development do
  gem 'spring-commands-rspec'
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '~> 3.2'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem "capistrano", "~> 3.10", require: false
  gem "capistrano-rails", "~> 1.6", require: false
  gem 'capistrano-rbenv', '~> 2.2'
  gem 'capistrano-rbenv-vars', '~> 0.1'
  gem 'capistrano3-puma'
end

group :test do
  gem 'capybara', '>= 2.15'
  gem 'selenium-webdriver'
  gem 'webdrivers'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
