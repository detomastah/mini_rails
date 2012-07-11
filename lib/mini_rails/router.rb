module MiniRails
  class NoRouteFoundError < MiniRailsError
  end
  
  class Route
    attr_accessor :tokens, :execution_data
    
    def self.parse(route_str)
      route = self.new
      route.tokens = route_str.split(/[\/\.]/)
      return route
    end

    
    def match(request_path)
      request_tokens = request_path.split(/[\/\.]/)
      if request_tokens.length != self.tokens.length
        return false
      else
        self.execution_data = Hash.new
        self.tokens.length.times do |token_index|
          if self.tokens[token_index][0..0] == ":"
            param_name = self.tokens[token_index][1..-1].to_sym
            param_value = request_tokens[token_index]
            self.execution_data[param_name] = param_value
          else
            return false if self.tokens[token_index] != request_tokens[token_index]
          end
        end
      end
      return true
    end
  end    
  
  class Router
    def initialize
      @routes = []
      if block_given?
        yield self
      else
        raise "Unimplemented"
      end      
    end
    
    def find(request_path)
      @routes.each do |route|
        if route.match(request_path)
          return route
        end
      end
      nil
    end

    def method_missing(name, *args, &block)
      @routes << Route.parse(args[0])
    end
  end
end
