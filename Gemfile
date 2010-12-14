source :gemcutter

gem 'rails', '~>3.0'
gem 'devise'
gem 'simple_form'
gem 'haml'  
gem 'jquery-rails'
gem 'coderay'
gem 'kramdown'
gem "friendly_id", "~> 3.1"

# NOTE: bellow line make rspec.rake runnable (because it depends on RSpec::Core::RakeTask)
# TODO: rspec.rake should not require rspec gem
gem 'rspec-core', '~>2.0'

group :production do
  gem 'pg'
end

group :development do
  gem 'sqlite3-ruby', :require => 'sqlite3'
  gem 'nifty-generators'
  gem 'rails3-generators'

  # NOTE: autotest is not required for test (ci) environment
  gem 'autotest'
  gem 'autotest-notification'
end

group :test do
  gem 'rspec', '~>2.0'
  gem "shoulda", :require => 'shoulda'
  gem 'rspec-rails', '~>2.0'
  gem 'factory_girl_rails'
  gem 'simplecov'
end
