require File.join(File.dirname(__FILE__), "..","spec_helper")

module Navigator

  describe Plateu do

    before(:each) do
      @messenger = mock("messenger")
      @plateu = Plateu.new(@messenger)          
    end 
    
    
    it "should have a length" do
      @plateu.length 
    end  
  
    it "should have a way to set the length which accepts a new length" do
      @length = mock("length")
      @plateu.set_length(@length)
    end
    
    it "should update the length when a new length value is set" do
      @length = mock("length")
      @plateu.set_length(@length)
      @plateu.length.should == @length
      
    end
    
    it "should have a width" do
      @plateu.width 
    end
    
    it "should have a way to set the width which accepts a new width" do
      @width = mock("width")
      @plateu.set_width(@width)
    end
    
    it "should update the width when a new width value is set" do
      @width = mock("width")
      @plateu.set_width(@width)
      @plateu.width.should == @width
    end 
  end


end
