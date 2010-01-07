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
