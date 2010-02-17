module Navigator
  class Rover
  
    attr_reader :x_position, :y_position, :direction_facing, :direction_code
    attr_accessor :plateu 

    def initialize(messenger,x_position,y_position,direction_facing,plateu)
      @messenger = messenger
      @x_position = x_position.to_i
      @y_position = y_position.to_i
      @direction_facing = direction_facing
      @plateu = plateu
      @directions = ["North","East","South","West"]
      @direction_code = {"N" => "North", "E" => "East", "S" => "South", "W" => "West"} 
      @deactivate = false
    end
    
    def deactivate?
      @deactivate
    end
    
    def current_position
      @current_position = {"x_position" => @x_position, "y_position" => @y_position, "direction_facing" => @direction_facing}
    end
    
    def position_code
      #Outputs x,y and direction facing in the format 'X Y direction_code' eg. "1 2 N"
      "#{@x_position} #{@y_position} #{@direction_code.index(@direction_facing)}"
    end
    
    def move(instructions)
      instructions.chars.each do |instruction|
        if deactivate? 
          break 
        else
          case instruction
            when "L" then self.turn_left
            when "R" then self.turn_right
            when "M" then self.move_forward
            else 
              @messenger.puts "Warning: The following Rover received an invalid user instruction and for saftey stopped after the last valid move, at this position:"
              break #stops processing of instructions if an unexpected instruction is received.
          end
        end  
      end      
    end

    #By storing 'directions' in an array, the program can cycle through directions, like a clock with four points.
    #This makes the left and right turns simple to achieve based on applying +1 or -1 to the index of the directions array.
    
    def turn_left
      direction_id = @directions.find_index(@direction_facing) #Find id for current direction
      #point the direction of the direction id before the current unless at front of the array
      @direction_facing = @directions[direction_id - 1] # Negative index counts backwards from the end of the array
    end    
    
    def turn_right
      direction_id = @directions.find_index(@direction_facing) #Find id for current direction
      #point the direction of the direction id after the current unless at the end of the array
      @direction_facing = (@directions[direction_id] == @directions.last) ? @directions.first : @directions[direction_id + 1]
    end    
   
    def move_forward
      #Makes the Rover move forward in the direction the rover is currently facing
       boundry_error_message = "The following Rover attempted to fall off the plateu! Rover deactivated in current position"
      case direction_facing
        when "North" then 
          if @y_position == @plateu.length 
            @messenger.puts boundry_error_message
            @deactivate = true
          else
            @y_position = @y_position + 1
          end  
          
        when "South" then 
          if @y_position == 0 
            @messenger.puts boundry_error_message
            @deactivate = true
          else
            @y_position = @y_position - 1
          end
          
        when "East" then 
          if @x_position == @plateu.width
            @messenger.puts boundry_error_message
            @deactivate = true
          else
            @x_position = @x_position + 1
          end
          
        when "West" then 
          if @x_position == 0
            @messenger.puts boundry_error_message
            @deactivate = true
          else
            @x_position = @x_position - 1
          end
        else
          @messenger.puts "System Error: Rover has unexpectedly received invalid direction instructions. Shutting down for rover safety."
          @deactivate = true
      end    
    end 
            
  end
end
