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
          iv_map = Hash.new
          self.instance_variables.each {|iv| iv_map[iv] = self.instance_variable_get(iv) }
          render_view(self.class, method_name, iv_map)
        end
        @@allow_override = true
      end
    end
    
    def render_view(klass, method_name, iv_map)
      template_file = MiniRails::View::select_template(klass, method_name)
      f = File.open(template_file)
      template_string = f.read
      f.close
      view = MiniRails::View.new(template_string)
      rendered_view = view.render(iv_map)
      rendered_view
    end
  end
end
