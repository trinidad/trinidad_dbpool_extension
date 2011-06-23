require 'rubygems'
require 'rake'

namespace :dbpool do
begin
  require 'jeweler'
  Jeweler::Tasks.new do |gem|
    gem.name = "trinidad_dbpool"
    gem.summary = %Q{Addon to support database pools in Trinidad}
    gem.description = %Q{Addon to support database pools in Trinidad}
    gem.email = "calavera@apache.org"
    gem.homepage = "http://github.com/calavera/trinidad-dbpool"
    gem.authors = ["David Calavera"]
    gem.add_dependency "trinidad_jars"

    gem.add_development_dependency "rspec", ">= 1.2.9"

    gem.files = FileList['lib/trinidad_dbpool.rb', 'lib/trinidad_dbpool/webapp_extension.rb',
      'trinidad-libs/tomcat-dbcp.jar',
      'LICENSE', 'README.rdoc', 'VERSION']
    gem.has_rdoc = false
    gem.version = '0.2.0'
  end
  Jeweler::GemcutterTasks.new
rescue LoadError
  puts "Jeweler (or a dependency) not available. Install it with: gem install jeweler"
end
end

namespace :mysql_dbpool do
begin
  require 'jeweler'
  Jeweler::Tasks.new do |gem|
    gem.name = "trinidad_mysql_dbpool_extension"
    gem.summary = %Q{Addon to support MySql database pools in Trinidad}
    gem.description = %Q{Addon to support MySql database pools in Trinidad}
    gem.email = "calavera@apache.org"
    gem.homepage = "http://github.com/calavera/trinidad-dbpool"
    gem.authors = ["David Calavera"]
    gem.add_dependency "trinidad_dbpool"
    gem.add_development_dependency "rspec", ">= 1.2.9"
    gem.add_development_dependency 'mocha'

    gem.files = FileList['lib/trinidad_mysql_dbpool_extension.rb',
      'lib/trinidad_mysql_dbpool_extension/mysql_webapp_extension.rb',
      'trinidad-libs/mysql-connector-java-5.1.12-bin.jar',
      'LICENSE', 'README.rdoc', 'VERSION']
    gem.has_rdoc = false
  end
  Jeweler::GemcutterTasks.new
rescue LoadError
  puts "Jeweler (or a dependency) not available. Install it with: gem install jeweler"
end
end

namespace :postgresql_dbpool do
begin
  require 'jeweler'
  Jeweler::Tasks.new do |gem|
    gem.name = "trinidad_postgresql_dbpool_extension"
    gem.summary = %Q{Addon to support PostgreSQL database pools in Trinidad}
    gem.description = %Q{Addon to support PostgreSQL database pools in Trinidad}
    gem.email = "calavera@apache.org"
    gem.homepage = "http://github.com/calavera/trinidad-dbpool"
    gem.authors = ["David Calavera"]
    gem.add_dependency "trinidad_dbpool"
    gem.add_development_dependency "rspec", ">= 1.2.9"
    gem.add_development_dependency 'mocha'

    gem.files = FileList['lib/trinidad_postgresql_dbpool_extension.rb',
      'lib/trinidad_postgresql_dbpool_extension/postgresql_webapp_extension.rb',
      'trinidad-libs/postgresql-8.4-701.jdbc4.jar',
      'LICENSE', 'README.rdoc', 'VERSION']
    gem.has_rdoc = false
  end
  Jeweler::GemcutterTasks.new
rescue LoadError
  puts "Jeweler (or a dependency) not available. Install it with: gem install jeweler"
end
end

namespace :mssql_dbpool do
begin
  require 'jeweler'
  Jeweler::Tasks.new do |gem|
    gem.name = "trinidad_mssql_dbpool_extension"
    gem.summary = %Q{Addon to support Mssql database pools in Trinidad}
    gem.description = %Q{Addon to support Mssql database pools in Trinidad}
    gem.email = "btatnall@gmail.com"
    gem.homepage = "http://github.com/calavera/trinidad-dbpool"
    gem.authors = ["Brian Tatnall"]
    gem.add_dependency "trinidad_dbpool"
    gem.add_development_dependency "rspec", ">= 1.2.9"
    gem.add_development_dependency 'mocha'

    gem.files = FileList['lib/trinidad_mssql_dbpool_extension.rb',
      'lib/trinidad_mssql_dbpool_extension/mssql_webapp_extension.rb',
      'trinidad-libs/jtds-1.2.5.jar',
      'LICENSE', 'README.rdoc', 'VERSION']
    gem.has_rdoc = false
  end
  Jeweler::GemcutterTasks.new
rescue LoadError
  puts "Jeweler (or a dependency) not available. Install it with: gem install jeweler"
end
end

namespace :oracle_dbpool do
begin
  require 'jeweler'
  Jeweler::Tasks.new do |gem|
    gem.name = "trinidad_oracle_dbpool_extension"
    gem.summary = %Q{Addon to support Oracle database pools in Trinidad}
    gem.description = %Q{Addon to support Oracle database pools in Trinidad}
    gem.email = "btatnall@gmail.com"
    gem.homepage = "http://github.com/calavera/trinidad-dbpool"
    gem.authors = ["Brian Tatnall"]
    gem.add_dependency "trinidad_dbpool"
    gem.add_development_dependency "rspec", ">= 1.2.9"
    gem.add_development_dependency 'mocha'

    gem.files = FileList['lib/trinidad_oracle_dbpool_extension.rb',
      'lib/trinidad_oracle_dbpool_extension/oracle_webapp_extension.rb',
      'trinidad-libs/ojdbc14.jar',
      'LICENSE', 'README.rdoc', 'VERSION']
    gem.has_rdoc = false
  end
  Jeweler::GemcutterTasks.new
rescue LoadError
  puts "Jeweler (or a dependency) not available. Install it with: gem install jeweler"
end
end

{
  :build => 'Build all connection pool gems', 
  :release => 'Release all connection pool gems'
}.each do |t, d|
  desc d
  task t => ["dbpool:#{t}", "mysql_dbpool:#{t}", "postgresql_dbpool:#{t}", "mssql_dbpool:#{t}", "oracle_dbpool:#{t}"]
end

require 'spec/rake/spectask'
Spec::Rake::SpecTask.new(:spec) do |spec|
  spec.libs << 'lib' << 'spec'
  spec.spec_opts = ['--options', 'spec/spec.opts']
  spec.spec_files = FileList['spec/**/*_spec.rb']
end

Spec::Rake::SpecTask.new(:rcov) do |spec|
  spec.libs << 'lib' << 'spec'
  spec.pattern = 'spec/**/*_spec.rb'
  spec.rcov = true
end

task :default => :spec

require 'rake/rdoctask'
Rake::RDocTask.new do |rdoc|
  version = File.exist?('VERSION') ? File.read('VERSION') : ""

  rdoc.rdoc_dir = 'rdoc'
  rdoc.title = "trinidad-dbpool #{version}"
  rdoc.rdoc_files.include('README*')
  rdoc.rdoc_files.include('lib/**/*.rb')
end
