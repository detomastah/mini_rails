$LOAD_PATH.unshift File.expand_path('../lib')
require 'mini_rails'

describe MiniRails, "#controllers" do
  it "should create method and render greeting" do
    class TestController < MiniRails::Controller
      def say_hello
        @name = "Lukasz"
      end
      
      def render_view(klass, method_name) #mock
        "Hello #{@name}"
      end
    end
    puts TestController.new.say_hello.inspect
    TestController.new.say_hello.should eq("Hello Lukasz")
  end
end


describe MiniRails, "#views" do
  it "should render view" do
    f = File.open('spec/views/list.erb')
    file_content = f.read
    f.close
    @counter = 3
    @name = "Lukasz"
    view = MiniRails::View.new(file_content)
    rendered_view = view.render(binding)
    rendered_view.scan(/[012]/).length.should eq(3)  
    rendered_view.scan(/Lukasz/).should_not be_empty
  end
end
