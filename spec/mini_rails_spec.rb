require 'spec_helper'

class TestController < MiniRails::Controller
  def say_hello
    @name = "Lukasz"
  end
  
  def render_view(klass, method_name, iv_map) #mock
    "Hello #{@name}"
  end
end

describe MiniRails, "#controllers" do
  it "should create method and render greeting" do
    TestController.new.say_hello.should eq("Hello Lukasz")
  end
end

describe MiniRails, "#views" do
  it "should render view" do
    f = File.open('spec/views/list.erb')
    file_content = f.read
    f.close

    view = MiniRails::View.new(file_content)
    rendered_view = view.render({"@name" => "Lukasz", "@counter" => 3})
    rendered_view.scan(/[012]/).length.should eq(3)  
    rendered_view.scan(/Lukasz/).should_not be_empty
  end
  
  it "should choose proper template" do
    MiniRails::View.select_template(TestController, :select).should match(/\/app\/views\/test\/select.erb\z/)
  end
end

describe MiniRails, "#routes" do
  it "should find a proper route" do
    router = MiniRails::DefaultRouter.new do |map|
      map.default("/namespace/:controller/elphel")
      map.default("/namespace/:controller/:action")
      map.default("/namespace/:controller/:action/omega")
    end
    
    route = router.find("/namespace/test/start")

    route.execution_data[:controller].should eq("test")
    route.execution_data[:action].should eq("start")
  end
  
  it "should execute route" do
    router = MiniRails::DefaultRouter.new do |map|
      map.default("/:controller/:action")
    end
    
    result = router.execute("/test/say_hello")
    result.should eq("Hello Lukasz")
  end
end
