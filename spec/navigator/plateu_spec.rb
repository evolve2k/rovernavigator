require File.join(File.dirname(__FILE__), "..","spec_helper")

module Navigator

  describe Plateu do

    before(:each) do
      @messenger = mock("messenger")
      @plateu = Plateu.new(@messenger)          
    end 
    
    it "should have a length" do
      @plateu.should respond_to(:length) 
    end  
  
    it "should have a way to set the length which accepts a new length" do
      @plateu.should respond_to(:length=)
    end
    
    it "should update the length when a new length value is set" do
      @length = mock("length")
      @plateu.length = @length
      @plateu.length.should == @length
    end
    
    it "should have a width" do
      @plateu.should respond_to(:width) 
    end
    
    it "should have a way to set the width which accepts a new width" do
      @plateu.should respond_to(:width=)
    end
    
    it "should update the width when a new width value is set" do
      @width = mock("width")
      @plateu.width = @width
      @plateu.width.should == @width
    end 
  end
end
