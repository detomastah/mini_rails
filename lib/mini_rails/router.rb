module MiniRails
  class NoRouteFoundError < MiniRailsError
  end
  
  class << self
    def router=(router) 
      @router = router
    end
    
    def router
      @router
    end
  end
  
  class DefaultRoute
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
    
    def execute
      controller = self.execution_data[:controller] + "_controller"
      action = self.execution_data[:action]
      controller.camelize.constantize.new.send(action)
    end
  end    


  #every router must implement execute(request_path)  
  class DefaultRouter
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
    
    def execute(request_path)
      route = self.find(request_path)
      if route
        route.execute
      else
        raise NoRouteFoundError, "Route not found in routing table"
      end
    end

    def method_missing(name, *args, &block)
      @routes << DefaultRoute.parse(args[0])
    end
  end
end
