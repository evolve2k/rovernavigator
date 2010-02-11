require File.join(File.dirname(__FILE__), "..","spec_helper")

module Navigator

  describe Rover do

    before(:each) do
      @messenger = mock("messenger").as_null_object
      @plateu = mock("plateu")
      @plateu.stub(:length).and_return(5)
      @plateu.stub(:width).and_return(5)
      @rover = Rover.new(@messenger,1,2,"North",@plateu)
    end
     
    it "should have a x position" do 
      @rover.should respond_to(:x_position)
    end
    
    it "should have a y position" do
      @rover.should respond_to(:y_position)
    end   
    
    it "should have a direction facing" do
      @rover.should respond_to(:direction_facing)
    end

    it "should have a current position" do
      @x_position = @rover.x_position
      @y_position = @rover.y_position
      @direction_facing = @rover.direction_facing
      @current_position = @rover.current_position
      @current_position.should == { "x_position" => 1, "y_position" => 2, "direction_facing" => "North"}
    end
    
    it "should be able to know details of the plateu it is on" do
      @rover.should respond_to(:plateu)
    end 
    
    it "should have a current position shortcode eg '1 2 N'" do
      @rover.should respond_to(:position_code)
      @rover.position_code.should == "#{@rover.x_position} #{@rover.y_position} #{@rover.direction_code.index(@rover.direction_facing)}"
    end
       
    context "when I send a move command to a rover" do
      
      it "should be able to move when I give it instructions to move" do         
        @rover.should respond_to(:move)
      end
      
      it "should change direction left if sent a command to turn left" do
        #initial direction is "North"
        desired_direction = "West"
        @rover.move "L"
        @rover.direction_facing.should == desired_direction
        
      end  

      it "should see all directions when rotating left in a full circle" do
        @rover.move("L")
        @rover.direction_facing.should == "West"
        @rover.move("L")
        @rover.direction_facing.should == "South"
        @rover.move("L")
        @rover.direction_facing.should == "East"
        @rover.move("L")
        @rover.direction_facing.should == "North"
      end

      
      it "should change direction right if sent a command to turn right" do
        desired_direction = "East"
        @rover.move("R")
        @rover.direction_facing.should == desired_direction
      end

      it "should see all directions when rotating right in a full circle" do
        @rover.move("R")
        @rover.direction_facing.should == "East"
        @rover.move("R")
        @rover.direction_facing.should == "South"
        @rover.move("R")
        @rover.direction_facing.should == "West"
        @rover.move("R")
        @rover.direction_facing.should == "North"
      end

      
    end    
   
    context "moving" do
      context "in the direction it is currently facing" do
  
        it "should move north if facing north" do
          @rover = Rover.new(@messenger,2,2,"North", @plateu)
          @rover.move("M")
          @rover.current_position.should == {"x_position" => 2,"y_position" => 3,"direction_facing" => "North"}          
        end
    
        it "should move south if facing south" do
          @rover = Rover.new(@messenger,2,2,"South", @plateu)
          @rover.move("M")
          @rover.current_position.should == {"x_position" => 2,"y_position" => 1,"direction_facing" => "South"}
        end
    
        it "should move east if facing east" do
          @rover = Rover.new(@messenger,2,2,"East", @plateu)
          @rover.move("M")
          @rover.current_position.should == {"x_position" => 3,"y_position" => 2,"direction_facing" => "East"}
        end
        
        it "should move west if facing west" do
          @rover = Rover.new(@messenger,2,2,"West", @plateu)
          @rover.move("M")
          @rover.current_position.should == {"x_position" => 1,"y_position" => 2,"direction_facing" => "West"}
        end
        
        describe "should check if the next move is invalid before moving" do
          
          describe "should not move forward if that move would put it outside the plateu" do
          
            it "should not move north" do
              @rover = Rover.new(@messenger,5,5,"North",@plateu)
              @rover.move("M")
              @rover.current_position.should == {"x_position" => 5,"y_position" => 5,"direction_facing" => "North"}
            end
          
            it "should not move south" do
              @rover = Rover.new(@messenger,0,0,"South",@plateu)
              @rover.move("M")
              @rover.current_position.should == {"x_position" => 0,"y_position" => 0,"direction_facing" => "South"}
            end
          
            it "should not move east" do
              @rover = Rover.new(@messenger,5,5,"East",@plateu)
              @rover.move("M")
              @rover.current_position.should == {"x_position" => 5,"y_position" => 5,"direction_facing" => "East"}
            end
          
            it "should not move west" do
              @rover = Rover.new(@messenger,0,0,"West",@plateu)
              @rover.move("M")
              @rover.current_position.should == {"x_position" => 0,"y_position" => 0,"direction_facing" => "West"}
            end
          
            it "should report an error" do
              @messenger.should_receive(:puts).with("The following Rover attempted to fall off the plateu! Rover deactivated in current position")
              @rover = Rover.new(@messenger,0,0,"West",@plateu)
              @rover.move("M")
            end
           
             it "should stop where it is" do
               @rover = Rover.new(@messenger,3,3,"North",@plateu)
               @rover.move("MMMRMMM") #directions will send the rover off the north boundry
               @rover.current_position.should == {"x_position" => 3,"y_position" => 5,"direction_facing" => "North"}
             end
             
             it "should have a method to deactivate the rover from taking further action" do
               @rover.should respond_to(:deactivate?)
             end
           
          end     
        end
        
      end
    end
    
    it "should be able to accept and process a string of instructions" do
       @rover = Rover.new(@messenger,0,0,"North",@plateu)
       @rover.move("MMMMM") 
       @rover.current_position.should == {"x_position" => 0,"y_position" => 5,"direction_facing" => "North"}   
    end
    
    describe "when the rover receives invalid instructions" do
      it "should stop processing further instructions" do
        @rover = Rover.new(@messenger,0,0,"North", @plateu)
        @rover.move("MMRMMXRMMM") #Move includes an invalid command 'X' is an invalid character
        @rover.current_position.should == {"x_position" => 2,"y_position" => 2,"direction_facing" => "East"}   
      end
      
      it "should report that it has stopped processing instructions" do
        @rover = Rover.new(@messenger,0,0,"North", @plateu)        
        @messenger.should_receive(:puts).with("Warning: The following Rover received an invalid user instruction and for saftey stopped after the last valid move, at this position:")  
        @rover.move("MMRMMXRMMM") #Move includes an invalid command. 'X' is an invalid character
      end  
    
    end
               
  end
end
