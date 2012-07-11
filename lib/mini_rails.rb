require 'mini_rails/view'
require 'mini_rails/controller'


module MiniRails
  module VERSION #:nodoc:
    MAJOR = 0
    MINOR = 0
    TINY  = 1

    STRING = [MAJOR, MINOR, TINY].join('.')
  end

  
  SKIP_VERIFY_ENV = ['test']

  def self.configuration
    @configuration ||= Configuration.new
  end

  def self.configure
    config = configuration
    yield(config)
  end

  class MiniRailsError < StandardError
  end
end
