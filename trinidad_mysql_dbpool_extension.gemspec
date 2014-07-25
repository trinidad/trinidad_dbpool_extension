# -*- encoding: utf-8 -*-

Gem::Specification.new do |gem|
  gem.name = "trinidad_mysql_dbpool_extension"
  gem.version = '0.8.0'

  gem.summary = "Addon to support MySQL database pools in Trinidad"
  gem.description = "Addon to support MySQL database pools in Trinidad"
  gem.homepage = "http://github.com/trinidad/trinidad_dbpool_extension"
  gem.authors = ["David Calavera"]
  gem.email = "calavera@apache.org"

  gem.files =  [ "lib/trinidad_mysql_dbpool_extension.rb" ] +
  `git ls-files lib/trinidad_mysql_dbpool_extension/*.rb`.split("\n") +
  `git ls-files `.split("\n").
    select { |name| File.dirname(name) == File.dirname(__FILE__) }.
    select { |name| name !~ /^\./ && name !~ /gemspec/ }

  gem.require_paths = ["lib"]

  gem.extra_rdoc_files = [ 'README.md', 'History.txt', 'LICENSE' ]

  gem.add_dependency('trinidad_dbpool', ">= 0.8.0")
  gem.add_dependency('jdbc-mysql', ">= 5.1.25")
end
