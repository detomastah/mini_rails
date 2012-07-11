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
    
    def render(custom_binding)
      ERB.new(@template_string).result(custom_binding)
    end
    
    
  end
end
