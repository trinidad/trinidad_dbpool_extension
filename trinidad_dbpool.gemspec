# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = "trinidad_dbpool"
  s.version = "0.4.0"

  s.summary = "Addon to support database pools in Trinidad"
  s.description = "Addon to support database pools in Trinidad"
  s.homepage = "http://github.com/trinidad/trinidad_dbpool_extension"
  s.authors = ["David Calavera"]
  s.email = "calavera@apache.org"
  
  s.files =  [ "lib/trinidad_dbpool.rb" ] +
  `git ls-files lib/trinidad_dbpool/*.rb`.split("\n") + 
  `git ls-files trinidad-libs/tomcat-dbcp.jar`.split("\n") + 
  `git ls-files `.split("\n").
    select { |name| File.dirname(name) == File.dirname(__FILE__) }.
    select { |name| name !~ /^\./ && name !~ /gemspec/ }
  
  s.require_paths = ["lib"]
  
  s.extra_rdoc_files = [
    "LICENSE",
    "README.rdoc"
  ]

  s.add_dependency('trinidad_jars', ">= 1.0.2")
  s.add_development_dependency('rspec', ">= 2.10")
  s.add_development_dependency('mocha', '>= 0.10')
end
