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
       @system.instruction_file = 'instructions/input1.txt'
       @messenger.should_receive(:puts).with("File read and processed successfully!")
       @system.read_file
     end
   
   end   
   
   context "initializing the plateu from the input data" do
     it "should read the plateu definition and create inputs for creating a new plateu" do
       @system.plateu_definition = '5 7'
       @system.should respond_to(:plateu_width_definition)
       @system.should respond_to(:plateu_length_definition)
       @system.initialize_plateu
       @system.plateu_width_definition.should == 5
       @system.plateu_length_definition.should == 7
     end 
         
     it "should create a new plateu using the newly defined plateu inputs" do
       @system.plateu_definition = '5 7'
       @system.initialize_plateu       
       #@plateu.width.should == @system.plateu_width_definition
       #@plateu.length.should == @system.plateu_length_definition
     end
     
     it "should read the plateu definition and check that the inputs are valid" do
#      Valid numbers are positive integers greater than zero
#      Should store the 
#      @system.plateu_definition = '7 9'
#      @system.initialize_plateu
     end 

        
   end
   
   context "initializing the rovers from the input data" do
     it "should read a rover start position and create a new rover" do
       start_position = "1 2 N"
       @system.rovers
           
     end
     
     it "should print the current rover position code after moving" do
       #@messenger.should_receive(:puts).with("1 2 N")
       #@messenger.puts @rover.position_code
     end
   
     it "should read lines in the instruction file and create inputs for creating a new rover" 
     it "should read in the start position and break it into key components" 
     it "should read each rovers start position and check that input is valid" 
     it "should read each rovers instructions and check that they are valid"
     it "should create a new rover object and send it instructions to move"    
   end
   
   context "Error handling" do
     it "should ensure that plateu height is greater than 0"
     it "should ensure that plateu width is greater than 0"
     
   end
   
  end   
end
