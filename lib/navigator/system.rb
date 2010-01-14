module Navigator
  class System

    attr_accessor :instruction_file
    attr_accessor :plateu_definition
    attr_reader :rovers, :plateu_width_definition, :plateu_length_definition


    def initialize(messenger)
      @messenger = messenger
      @direction_code = {"N" => "North", "E" => "East", "S" => "South", "W" => "West"}
    end

    def start
      @messenger.puts "--< Welcome to the NASA Mars Rover Navigation Console >--"
      @messenger.puts "Enter name of instruction file to process {eg instructions/input1.txt (default)}:"
    end

    def get_file
      @instruction_file = gets.chomp
      initialize_file
    end
    
    def initialize_file
      @instruction_file = "instructions/input1.txt" if (@instruction_file.nil? || @instruction_file.empty?)
    end

    def check_if_file_exists
      File.exists?(@instruction_file)
    end
    
    def read_file
      @rovers = []
      rover_number = 0
      File.open(@instruction_file,"r") do |file|
        @messenger.puts "Processing File.."      
        @plateu_definition = file.gets.chomp #sets the plateu size definition to the first line of the file
        @messenger.puts "Plateu area defined: " + @plateu_definition   
        while line = file.gets
          rover_definition = {:start_position => line.split, :instructions => file.gets.chomp}
          @rovers << rover_definition
          @messenger.puts "Rover #{rover_number = rover_number + 1}:"
          @messenger.puts " - Start position: #{rover_definition[:start_position]}"
          @messenger.puts " - Instructions: #{rover_definition[:instructions]} \n"  
        end
      end
      @messenger.puts "File read successfully"
      @messenger.puts "Output:"      
      initialize_plateu(@plateu_definition)
      initialize_rovers(@rovers)
    end
    
    def initialize_plateu(plateu_definition)
      if valid_plateu_definition?(plateu_definition)
        @plateu_width_definition = plateu_definition.split.first.to_i
        @plateu_length_definition = plateu_definition.split.last.to_i
        @plateu = Navigator::Plateu.new(@messenger)
        @plateu.width = @plateu_width_definition
        @plateu.length = @plateu_length_definition
      else
        @messenger.puts "Plateu definition is invalid. Exiting system. Please change plateu definition and restart system"
      end
    end
    
    def initialize_rovers(rovers)
      rovers.each do |rover_input|
        process_rover(rover_input)
      end    
    end

    def process_rover(rover_input)
      start_position = rover_input[:start_position]
      if valid_rover_position?(start_position)
        x_definition = start_position[0]
        y_definition = start_position[1]
        direction_definition = start_position[2]
        @rover = Navigator::Rover.new(@messenger, x_definition, y_definition, @direction_code[direction_definition])
        instructions_definition = rover_input[:instructions]
        #process_rover_start_position(start_position)
        @rover.move(instructions_definition)
        @messenger.puts @rover.position_code
      else
        @messenger.puts "Rover start position is invalid. No moves will be processed for this rover"
      end
    end
    
    def valid_plateu_coordinate?(coordinate)
       coordinate > 0 ? true : false
    end
    
    def valid_plateu_definition?(plateu_definition)
      width_coordinate = plateu_definition.split.first.to_i
      length_coordinate = plateu_definition.split.last.to_i
      if valid_plateu_coordinate?(width_coordinate) && valid_plateu_coordinate?(length_coordinate) 
        return true
      else
        return false
      end 
    end
    
    def valid_rover_coordinate?(coordinate)
      coordinate < 0 ? false : true
    end
    
    def valid_direction_code?(direction_code)
      @direction_code.has_key?(direction_code) ? true : false
    end
    
    def valid_rover_position?(position_code)
      x_coordinate = position_code[0].to_i
      y_coordinate = position_code[1].to_i
      direction_code = position_code[2]
      if valid_rover_coordinate?(x_coordinate) && 
         valid_rover_coordinate?(y_coordinate) && 
         valid_direction_code?(direction_code) then
         return true
      else 
         return false
      end
    end 
  end
end
