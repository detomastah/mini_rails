module MiniRails
  class NoRouteFoundError < MiniRailsError
  end
  
  class Route
    attr_accessor :parse_data, :execution_data, :route_str, :tail
    
    def self.parse(route_str)
      route = self.new
      route.route_str = String.new(route_str)
      route.parse_data = []
      param_regexp = /:[a-z]+[a-z0-9_]*/
      
      index = route_str =~ param_regexp
      while index
        skip_chars = index  
        name = route_str[index..-1].match(param_regexp).to_s
        route.parse_data << [skip_chars, name[1..-1].to_sym]
        
        route_str = route_str[(index + name.length)..-1]
        index = route_str =~ param_regexp
      end
      #is something left?
      route.tail = route_str
      return route
    end
    
    def match(request_path)
      processed = 0
      param_value_regexp = /[^\/]*/
      self.execution_data = Hash.new
      self.parse_data.each do |parse_pair|
        request_path = request_path[parse_pair[0]..-1]
        param_value = request_path.match(param_value_regexp).to_s
        self.execution_data[parse_pair[1]] = param_value
        request_path = request_path[param_value.length..-1]
        processed += 1
      end
      return processed == parse_data.length && self.tail == request_path
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
