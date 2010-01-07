require File.join(File.dirname(__FILE__), "..","spec_helper")

module Navigator

  describe System do  
    context "starting up" do
    
      before(:each) do
        @messenger = mock("messenger").as_null_object
        @system = System.new(@messenger)
      end
    
      it "should send a welcome message" do
        @messenger.should_receive(:puts).with("--< Welcome to the NASA Mars Rover Navigation Console >--")      
        @system.start
      end
      
      it "should prompt for the user to initialize the plateu size" do
        @messenger.should_receive(:puts).with("First define size of plateu (grid area)")
        @messenger.should_receive(:puts).with("Enter Plateu Size (eg for 5x5 type '5 5'):")
        @system.start
      end
      
    end
  end
  
end
