require 'rake'
require 'rubygems'
require 'rspec/core/rake_task'
require 'treetop'
require File.expand_path("../lib/mini_rails", __FILE__)

begin
  require 'jeweler'
  Jeweler::Tasks.new do |gem|
    gem.name           = "mini_rails"
    gem.version = MiniRails::VERSION::STRING
    gem.description    = "This plugin is a small framework inspired by Rails"
    gem.summary        = "This plugin is a small framework inspired by Rails"
    gem.homepage       = "http://lpelszyn.posterous.com"
    gem.authors        = ["Lukasz Pelszynski"]
    gem.email          = "lukaszp@lavabit.com"
    gem.files.reject! { |fn| fn.include? ".gitignore" }
    #gem.add_development_dependency "mocha"
  end
  Jeweler::GemcutterTasks.new
rescue LoadError
  puts "Jeweler (or a dependency) not available. Install it with: sudo gem install jeweler"
end

RSpec::Core::RakeTask.new(:spec)

task :default => :spec



