Given /^I have not yet entered any navigation instructions$/ do
end

When /^I start the navigation system$/ do
  @messenger = StringIO.new
  @system = Navigator::System.new(@messenger)
  @system.start
end

Then /^I should see "([^\"]*)"$/ do |message|
  @messenger.string.split("\n").should include(message)
end

Given /^I have started the system$/ do
  @messenger = StringIO.new
  @system = Navigator::System.new(@messenger)
  @system.start
end

When /^I provide a instruction file called '([^\"]*)'$/ do |filename|
  @filename = filename
  @system.instruction_file = @filename
end

Then /^the system should read in the file and have it ready for processing$/ do
  @system.read_file
end

Then /^the system should process the file and move the rover at start position '([^\"]*)'$/ do |start_position|
  @start_position = start_position
  puts start_position
  #plateu = Navigator::Plateu.new(@messenger)
  #rover = Navigator::Rover.new(@messenger, @x_position, @y_position, @direction_facing)
  
end

Then /^display the final position of the rover to the screen as '([^\"]*)'$/ do |final_position|

  rover_definition = {:start_position => [3, 3, "E"], :instructions => "MMRMMRMRRM"}
  @system.process_rover(rover_definition).should == '5 1 E'
  
  #puts rover_definition = {:start_position => @start_position, :instructions => "LMLMLMLMM"}
  #@system.process_rover(rover_definition).should == final_position
  #rover = Navigator::Rover.new(@messenger, @x_position, @y_position, @direction_facing)
  #rover.position_code.should == final_position

end
