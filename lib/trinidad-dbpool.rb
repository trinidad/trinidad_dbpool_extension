$:.unshift(File.dirname(__FILE__)) unless
  $:.include?(File.dirname(__FILE__)) || $:.include?(File.expand_path(File.dirname(__FILE__)))

require 'java'
require 'rubygems'
gem 'trinidad_jars'

require 'trinidad/jars'
require 'trinidad-dbpool/webapp_addon'
