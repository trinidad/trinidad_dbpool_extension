# -*- encoding: utf-8 -*-

Gem::Specification.new do |gem|
  gem.name = "trinidad_dbpool"
  gem.version = "0.4.2"

  gem.summary = "Addon to support database pools in Trinidad"
  gem.description = "Addon to support database pools in Trinidad"
  gem.homepage = "http://github.com/trinidad/trinidad_dbpool_extension"
  gem.authors = ["David Calavera"]
  gem.email = "calavera@apache.org"
  
  gem.files =  [ "lib/trinidad_dbpool.rb" ] +
  `git ls-files lib/trinidad_dbpool/*.rb`.split("\n") + 
  `git ls-files trinidad-libs/tomcat-dbcp.jar`.split("\n") + 
  `git ls-files `.split("\n").
    select { |name| File.dirname(name) == File.dirname(__FILE__) }.
    select { |name| name !~ /^\./ && name !~ /gemspec/ }
  
  gem.require_paths = ["lib"]
  
  gem.extra_rdoc_files = [ 'README.md', 'History.txt', 'LICENSE', 'Rakefile' ]

  gem.add_dependency('trinidad_jars', ">= 1.0.2")
  gem.add_development_dependency('rspec', ">= 2.10")
  gem.add_development_dependency('mocha', '>= 0.10')
end
