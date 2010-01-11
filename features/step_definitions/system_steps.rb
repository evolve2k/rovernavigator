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

Then /^the system should process the file and move the rover at start position 1 2 N$/ do
  @messenger = StringIO.new
  system = Navigator::System.new(@messenger)
  system.start
  system.get_file
  system.read_file
  rover = Navigator::Rover.new(
  
  
end

Then /^display the final position of the rover to the screen as 1 3 N$/ do
  pending # express the regexp above with the code you wish you had
end

Then /^the system should process the file and move the rover at start position 3 3 E$/ do
  pending # express the regexp above with the code you wish you had
end

Then /^display the final position of the rover to the screen as 5 1 E$/ do
  pending # express the regexp above with the code you wish you had
end




