#require File.join(File.dirname(__FILE__), 'lib', 'haml')

require 'bundler/setup'
Bundler.require

require './lib/haml/engine'
require './lib/haml/parser'

#require 'haml'

haml_str = <<HAML
#ruby_som
  #setting_frame
    %label#dsfs rows
    %combobox#ad{:values => [1,2,3,4]}

  #content_frame{:width => 31}
HAML

haml = Haml::Engine.new haml_str

#puts haml.render
puts haml.to_tk_module
haml.render_tk_module
