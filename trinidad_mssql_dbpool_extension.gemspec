# -*- encoding: utf-8 -*-

Gem::Specification.new do |gem|
  gem.name = "trinidad_mssql_dbpool_extension"
  gem.version = '0.7.0'

  gem.summary = "Addon to support MS SQL Server database pools in Trinidad"
  gem.description = "Addon to support MS SQL Server database pools in Trinidad"
  gem.homepage = "http://github.com/trinidad/trinidad_dbpool_extension"
  gem.authors = ["Brian Tatnall"]
  gem.email = %q{btatnall@gmail.com}

  gem.files =  [ "lib/trinidad_mssql_dbpool_extension.rb" ] +
  `git ls-files lib/trinidad_mssql_dbpool_extension/*.rb`.split("\n") +
  `git ls-files `.split("\n").
    select { |name| File.dirname(name) == File.dirname(__FILE__) }.
    select { |name| name !~ /^\./ && name !~ /gemspec/ }

  gem.require_paths = ["lib"]

  gem.extra_rdoc_files = [ 'README.md', 'History.txt', 'LICENSE' ]

  gem.add_dependency('trinidad_dbpool', ">= 0.7.0")
  gem.add_dependency('jdbc-jtds', ">= 1.2.8")
end
