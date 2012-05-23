# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = "trinidad_oracle_dbpool_extension"
  s.version = '0.1.0'
  
  s.summary = "Addon to support Oracle database pools in Trinidad"
  s.description = "Addon to support Oracle database pools in Trinidad"
  s.homepage = "http://github.com/trinidad/trinidad_dbpool_extension"
  s.authors = ["Brian Tatnall"]
  s.email = %q{btatnall@gmail.com}
  
  s.files =  [ "lib/trinidad_oracle_dbpool_extension.rb" ] +
  `git ls-files lib/trinidad_oracle_dbpool_extension/*.rb`.split("\n") + 
  `git ls-files trinidad-libs/*ojdbc*.jar`.split("\n") + 
  `git ls-files `.split("\n").
    select { |name| File.dirname(name) == File.dirname(__FILE__) }.
    select { |name| name !~ /^\./ && name !~ /gemspec/ }
  
  s.require_paths = ["lib"]

  s.extra_rdoc_files = [
    "LICENSE",
    "README.rdoc"
  ]
  
  s.add_dependency('trinidad_dbpool', ">= 0.3.0")
  s.add_development_dependency('rspec', ">= 2.10")
  s.add_development_dependency('mocha', '>= 0.10')
end
