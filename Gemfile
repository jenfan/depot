source 'https://rubygems.org'
ruby '2.1.0'
# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.0.2'
gem 'bcrypt-ruby', '3.1.2'
gem 'sass-rails', '~> 4.0.0'
gem 'bootstrap-sass', '2.3.2.0'
gem 'capistrano', '>= 3.0'
gem 'pg', '0.17.1'
gem 'turbolinks'

group :development do
	gem 'yaml_db', github: 'jetthoughts/yaml_db', ref: 'fb4b6bd7e12de3cffa93e0a298a1e5253d7e92ba'
	gem 'sqlite3'
	gem 'faker', '1.1.2'
	# gem 'rails_layout'
	gem 'capistrano-rails', require: false
  	gem 'capistrano-bundler', require: false
  	gem 'capistrano-rvm', require: false
end

group :assets do
	  # Use Uglifier as compressor for JavaScript assets
	gem 'uglifier', '>= 1.3.0'
	# Use CoffeeScript for .js.coffee assets and views
	gem 'coffee-rails', '~> 4.0.0'
end

group :production do
  
  # gem 'mysql'
  gem 'rails_12factor', '0.0.2'
  gem "activerecord-postgresql-adapter"
end

# See https://github.com/sstephenson/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

# Use jquery as the JavaScript library
gem "jquery-rails", "~> 2.3.0"
# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 1.2'
gem 'will_paginate', '~> 3.0'

# Use ActiveModel has_secure_password
# gem 'bcrypt-ruby', '~> 3.1.2'

# Use unicorn as the app server
# gem 'unicorn'

# Use Capistrano for deployment
# gem 'capistrano', group: :development

# Use debugger
# gem 'debugger', group: [:development, :test]
