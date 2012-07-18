require 'erb'

module MiniRails  
  class View
    def initialize(template_string)
      @template_string = template_string
    end
    
    def render(iv_map)
      iv_map.each_pair {|iv_name, iv_value| self.instance_variable_set(iv_name.to_sym, iv_value)}
      ERB.new(@template_string).result(binding)
    end
    
    def self.select_template(klass, method_name)
      controller_dir = klass.name.gsub(/Controller\z/, "").underscore
      template_filename = "#{method_name}.erb"
      return File.join(MiniRails.root, "app", "views", controller_dir, template_filename)
    end
  end
end
