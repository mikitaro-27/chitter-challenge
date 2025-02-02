require 'simplecov'
require 'simplecov-console'
require 'rspec'
require 'capybara/rspec'

# Set the environment to "test"
ENV['RACK_ENV'] = 'test'
ENV['ENVIRONMENT'] = 'test'

SimpleCov.formatter = SimpleCov::Formatter::MultiFormatter.new([
  SimpleCov::Formatter::Console,
  # Want a nice code coverage website? Uncomment this next line!
  # SimpleCov::Formatter::HTMLFormatter
])
SimpleCov.start

require File.join(File.dirname(__FILE__), '..', 'chitter.rb')
require File.join(File.dirname(__FILE__), 'setup_test_database.rb')

Capybara.app = Chitter

RSpec.configure do |config|
  config.before(:each) do
    setup_test_database
  end

end

RSpec.configure do |config|
  config.after(:suite) do
    puts
    puts "\e[33mRubocop?\e[0m"
  end
end
