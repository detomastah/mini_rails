$LOAD_PATH.unshift File.expand_path('../lib')
require 'mini_rails'

class << MiniRails
  def root
    File.join(File.expand_path("."), "spec", "test_app")
  end
end

describe MiniRails, "#test rendering" do
  it "should create method and render greeting" do
    class TestController < MiniRails::Controller
      def index
        @name = "Lukasz"
      end
    end
    
    TestController.new.index.strip.should eq("Hello Lukasz")
  end
end
