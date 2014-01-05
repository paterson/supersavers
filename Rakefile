# -*- coding: utf-8 -*-
$:.unshift("/Library/RubyMotion/lib")
require 'motion/project/template/ios'

begin
  require 'bundler'
  Bundler.require
rescue LoadError
end

require "nano-store"
require "formotion"


Motion::Project::App.setup do |app|
  # Use `rake config' to see complete project settings.
  app.name = 'super savers'

  app.pods do
    pod "NanoStore"
  end

end
