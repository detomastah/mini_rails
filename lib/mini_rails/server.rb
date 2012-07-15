require 'rack/request'
require 'rack/response'

module MiniRails
  class Server
    def call(env)
      puts "Request: #{env["REQUEST_PATH"]}"
      router = MiniRails::DefaultRouter.new do |map|
        map.default "/"
      end
      p MiniRails.root
      router.execute(env["REQUEST_PATH"])
      [200, {"Content-Type" => "text/plain"}, [env.inspect]]
    end
  end
end

