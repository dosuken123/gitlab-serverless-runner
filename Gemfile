source "https://rubygems.org"

gem "jets"

# Include webpacker if you are you are building html pages
gem "webpacker", git: "https://github.com/tongueroo/webpacker.git", branch: "jets"

# Include pg gem if you are using ActiveRecord, remove next line
# and config/database.yml file if you are not
gem "pg", "~> 1.1.3"

gem "dynomite"
gem "haml"
gem "haml-jets"
gem "httparty"
gem 'state_machines'
gem 'state_machines-activerecord'
gem 'file-tail'

# development and test groups are not bundled as part of the deployment
group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  gem 'shotgun'
  gem 'rack'
  gem 'puma'
  gem 'pry'
end

group :test do
  gem 'rspec' # rspec test group only or we get the "irb: warn: can't alias context from irb_context warning" when starting jets console
  gem 'launchy'
  gem 'capybara'
end
