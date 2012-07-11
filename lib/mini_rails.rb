module MiniRails
  module VERSION #:nodoc:
    MAJOR = 0
    MINOR = 0
    TINY  = 1

    STRING = [MAJOR, MINOR, TINY].join('.')
  end
  
  SKIP_VERIFY_ENV = ['test']

  class MiniRailsError < StandardError
  end
  
  class << self
    def root
      File.expand_path(".")
    end
  end
end

require 'active_support/all'
require 'mini_rails/view'
require 'mini_rails/controller'
require 'mini_rails/server'
require 'mini_rails/router'
