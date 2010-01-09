module Navigator
  class System

    attr_accessor :instruction_file
    attr_reader :plateu_definition
    attr_reader :rovers

    def initialize(messenger)
      @messenger = messenger
    end

    def start
      @messenger.puts "--< Welcome to the NASA Mars Rover Navigation Console >--"
      @messenger.puts "Enter name of instruction file to process {eg instructions/input1.txt (default)}:"
    end

    def get_file
      @instruction_file = gets.chomp
      @instruction_file = "instructions/input1.txt" if @instruction_file.empty?
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
      
      
       
    end

  end

end
