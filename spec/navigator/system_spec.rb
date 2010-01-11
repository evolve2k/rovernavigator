require File.join(File.dirname(__FILE__), "..","spec_helper")

module Navigator

  describe System do
  
    before(:each) do
      @messenger = mock("messenger").as_null_object
      @system = System.new(@messenger)
    end
  
    it "should have a instruction filename" do
      @system.should respond_to(:instruction_file)      
    end
  
    context "starting up" do    
      it "should send a welcome message" do
        @messenger.should_receive(:puts).with("--< Welcome to the NASA Mars Rover Navigation Console >--")      
        @system.start
      end

      it "should prompt for the user to enter the name of the instruction file to process" do
        @messenger.should_receive(:puts).with("Enter name of instruction file to process {eg instructions/input1.txt (default)}:")
        @system.start        
      end
    end
      
   context "reading a file" do
   
     it "should have a method to get a file" do
       @system.should respond_to(:get_file)
     end     
     
     it "should have a method to read the instruction file" do
       @system.should respond_to(:read_file)
     end
     
     it "should read in the instruction file and create rover definitions" do
       @system.instruction_file = 'instructions/input1.txt'
       @system.read_file
       @system.rovers.empty?.should be_false
     end
     
     it "should set the plateu definition to the first line of the file" do
       @system.instruction_file = 'instructions/input1.txt'
       first_line = "5 5"
       @system.read_file
       @system.should respond_to(:plateu_definition)
       @system.plateu_definition.nil?.should be_false
       @system.plateu_definition.should == first_line
     end
     
     it "should default instruction file to 'instructions/input1.txt' if no file is provided" do
       @system.instruction_file = ""
       @system.initialize_file
       @system.instruction_file.should == 'instructions/input1.txt'
     end  
     
     it "should ensure the selected file exist before processing the file further" do
       @system.instruction_file = "instructions/bogusfile.txt"
       @system.check_if_file_exists.should be_false
     end
     
     it "should report if the file has been read successfully" do
       
     end 
   
   
           
   end   
  end   
end
