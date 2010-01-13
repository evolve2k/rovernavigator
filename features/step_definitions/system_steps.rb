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

Then /^the system should process the file and move the rover at start position '([^\"]*)'$/ do |start_position|
  @messenger = StringIO.new
  system = Navigator::System.new(@messenger)
  system.start
  system.get_file
  system.read_file
  system.initialize_plateu
  system.initialize_rovers
  plateu = Navigator::Plateu.new(@messenger)
  rover = Navigator::Rover.new(@messenger, @x_position, @y_position, @direction_facing)
  
end

Then /^display the final position of the rover to the screen as '([^\"]*)'$/ do |final_position|
  @messenger = StringIO.new
  system = Navigator::System.new(@messenger)
  system.start
  system.get_file
  rover_definition = {:start_position => '1 2 N', :instructions => "LMLMLMLMM"}
  system.process_rover_instructions(rover_definition).should == final_position
  #rover = Navigator::Rover.new(@messenger, @x_position, @y_position, @direction_facing)
  #rover.position_code.should == final_position

end
