Given /^I have no directory called "([^"]*)"$/ do |arg1|
  FileUtils.rm_rf(arg1) if Dir.exists?(arg1)
end

Given /^I have execute permissions on the file "([^"]*)"$/ do |arg1|
  `chmod u+x #{arg1}`
end

Then /^the "([^"]*)" directory should exist$/ do |arg1|
  !Dir.exists? arg1
end

