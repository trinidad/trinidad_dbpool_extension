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
  end
  Jeweler::GemcutterTasks.new
rescue LoadError
  puts "Jeweler (or a dependency) not available. Install it with: gem install jeweler"
end
end

task :build => ["dbpool:build", "mysql_dbpool:build"]

task :install do

  `jruby -S gem install pkg/trinidad-dbpool-0.1.0.gem pkg/trinidad-mysql-dbpool-extension-0.1.0.gem --no-ri --no-rdoc`
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
