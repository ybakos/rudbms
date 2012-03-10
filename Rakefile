#!/usr/bin/env rake
require "bundler/gem_tasks"

task :default => :test

desc "Run test suite"
task :test do
  Dir['test/test_*.rb'].each { |file| require_relative file}
end