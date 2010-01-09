Given /^I have a plateu$/ do
  @messenger = StringIO.new
  plateu = Navigator::Plateu.new(@messenger)
end

Given /^the plateu is (\d*) units long by (\d*) units wide$/ do |length,width|
  @length = length.to_i
  @width = width.to_i
  @messenger = StringIO.new
  plateu = Navigator::Plateu.new(@messenger)
  plateu.set_length(@length)
  plateu.length.should == @length
  plateu.set_width(@width)
  plateu.width.should == @width
end

Given /^a I have a rover at position (\d*),(\d*) facing "([^\"]*)"$/ do |x,y,direction_facing|
  rover = Navigator::Rover.new(@messenger,x,y,direction_facing)
  @current_position = rover.current_position #returns hash of x,y,direction_facing
  @current_position.should == {"x_position" => x, "y_position" => y, "direction_facing" => direction_facing}  #Should equal a hash/array of the three inputs
end


When /^I give the rover the instructions "([^\"]*)"$/ do |instructions|
  @rover = Navigator::Rover.new(@messenger,1,2,"North")  
  @rover.move(instructions)  
end

Then /^the rover should move until it reaches the position (\d*),(\d*)$/ do |x,y|
  @rover.x_position.should == x.to_i
  @rover.y_position.should == y.to_i
end

Then /^the rover should be facing "([^\"]*)"$/ do |direction_facing|
  @rover.direction_facing.should == direction_facing
end
