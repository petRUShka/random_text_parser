require "rubygems"
require "bundler/setup"

require 'pp'
require 'parslet'

if RUBY_VERSION < "1.9"
  $KCODE = 'u'
  require 'jcode' unless "".respond_to? :each_char
end

class RandomTextParser < Parslet::Parser
  VERSION = "0.0.2"
end
