module Navigator
  class System

    attr_accessor :instruction_file
    attr_accessor :plateu_definition
    attr_reader :rovers, :plateu_width_definition, :plateu_length_definition


    def initialize(messenger)
      @messenger = messenger
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
      FileTest.exists?(@instruction_file)
    end
    
    def read_file
      @rovers = []
      rover_number = 0
      File.open(@instruction_file,"r") do |file|
        @messenger.puts "Processing File.."      
        @plateu_definition = file.gets.chomp #sets the plateu size definition to the first line of the file
        @messenger.puts "Plateu area defined: " + @plateu_definition   
        while line = file.gets
          rover_definition = {:start_position => line.split, :instructions => file.gets}
          @rovers << rover_definition
          @messenger.puts "Rover #{rover_number = rover_number + 1}:"
          @messenger.puts " - Start position: #{rover_definition[:start_position]}"
          @messenger.puts " - Instructions: #{rover_definition[:instructions]} \n"  
        end
      end

      @messenger.puts "File read and processed successfully!"
      @messenger.puts "Output:"      
      initialize_plateu
      initialize_rovers
    end
    
    def initialize_plateu
      @plateu_area = @plateu_definition.split
      @plateu_width_definition = @plateu_area[0].to_i
      @plateu_length_definition = @plateu_area[1].to_i
      @plateu = Navigator::Plateu.new(@messenger)
      @plateu.width = @plateu_width_definition
      @plateu.length = @plateu_length_definition
    end
    
    def initialize_rovers
      @direction_code = {"N" => "North", "E" => "East", "S" => "South", "W" => "West"}
      @rovers.each do |rover_input|
        process_rover_instructions(rover_input)
      end    
    end

    def process_rover_instructions(rover_input)
      x_definition = rover_input[:start_position][0]
      y_definition = rover_input[:start_position][1]
      direction_definition = rover_input[:start_position][2]
      @rover = Navigator::Rover.new(@messenger, x_definition, y_definition, @direction_code[direction_definition])
      @rover.move(rover_input[:instructions])
      @messenger.puts @rover.position_code
    end
   
  end

end
