module Navigator
  class System

    def initialize(messenger)
      @messenger = messenger
    end

    def start
      @messenger.puts "--< Welcome to the NASA Mars Rover Navigation Console >--"
      @messenger.puts "First define size of plateu (grid area)"
      @messenger.puts "Enter Plateu Size (eg for 5x5 type '5 5'):"
    end

  end

end
