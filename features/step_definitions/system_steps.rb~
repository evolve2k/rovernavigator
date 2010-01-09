Given /^I have not yet entered any navigation instructions$/ do
end

When /^I start the navigation system$/ do
  @messenger = StringIO.new
  system = Navigator::System.new(@messenger)
  system.start
end

Then /^I should see "([^\"]*)"$/ do |message|
  @messenger.string.split("\n").should include(message)
end

Given /^I have started the system$/ do
  @messenger = StringIO.new
  system = Navigator::System.new(@messenger)
  system.start
end

When /^I provide a instruction file called '([^\"]*)'$/ do |filename|
  @messenger = StringIO.new
  system = Navigator::System.new(@messenger)
  system.start
  system.get_file
end

Then /^the system should read in the file and have it ready for processing$/ do
  @messenger = StringIO.new
  system = Navigator::System.new(@messenger)
  system.start
  system.get_file
  system.read_file
end

