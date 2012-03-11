unless ENV['TRAVIS']
  require 'simplecov'
  SimpleCov.start
  SimpleCov.command_name 'Unit Tests'
  require 'turn'
end
require 'minitest/autorun'
