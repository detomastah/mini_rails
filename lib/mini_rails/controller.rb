module MiniRails
  class Controller
    @@allow_override = true
    def self.method_added method_name
      return if [:render_view].include?(method_name)
      if @@allow_override
        @@allow_override = false
        hidden_method_name = "hidden_#{method_name}".to_sym
        self.send :alias_method, hidden_method_name, method_name 
        self.send :remove_method, method_name
        self.send :define_method, method_name do
          self.send hidden_method_name
          render_view(self.class, method_name)
        end
        @@allow_override = true
      end
    end
  end
end
