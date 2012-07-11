require 'erb'

module MiniRails  
  class AbstractReponse
    def render(custom_binding)
      raise "Abstract Class"
    end
  end
  
  class View < AbstractReponse
    def initialize(template_string)
      @template_string = template_string
    end
    
    def render(iv_map)
      iv_map.each_pair {|iv_name, iv_value| self.instance_variable_set(iv_name.to_sym, iv_value)}
      ERB.new(@template_string).result(binding)
    end
    
    
  end
end
