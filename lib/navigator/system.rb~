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
      @instruction_file = "instructions/input1.txt" #if (@instruction_file.nil? || @instruction_file.empty?)
    end

    def check_if_file_exists
      FileTest.exists?(@instruction_file)
    end
    
    def read_file
      @rovers = []
      File.open(@instruction_file,"r") do |file|
        @plateu_definition = file.gets.chomp #sets the plateu size definition to the first line of the file
        while line = file.gets
          rover_definition = {:start_position => line, :instructions => file.gets}
          @rovers << rover_definition
        end
      end
      @messenger.puts "Plateu definition: " + @plateu_definition       
      @messenger.puts @rovers
      @messenger.puts @plateu_array
    end
    
    def process_instruction_file
    end
    
    def initialize_plateu
      @plateu_area = @plateu_definition.split
      @plateu_width_definition = @plateu_area[0].to_i
      @plateu_length_definition = @plateu_area[1].to_i
      #plateu_array.each do |p|
        #code
      #end 
      
    end
    
    def initialize_rovers
    
    end

  end

end
