begin
  require 'bundler/gem_helper'
rescue LoadError => e
  require('rubygems') && retry
  raise e
end

task :default => :spec

require 'rspec/core/rake_task'
RSpec::Core::RakeTask.new(:spec) do |spec|
  spec.rspec_opts = ['--color', "--format documentation"]
end

desc "Clear out all built (pkg/* and *.gem) artifacts"
task :clear do
  rm Dir["*.gem"]
  rm_r Dir["pkg/*"] if File.exist?("pkg")
end
task :clean => :clear

all_gems = %W{ 
  dbpool
  generic_dbpool_extension
  mysql_dbpool_extension
  postgresql_dbpool_extension
  sqlite_dbpool_extension
  mssql_dbpool_extension
  oracle_dbpool_extension
}.map { |gem| "trinidad_#{gem}" }

all_gems.each do |gem_name|
  
  gem_helper = Bundler::GemHelper.new(Dir.pwd, gem_name)
  def gem_helper.version_tag
    "#{name}-#{version}" # override "v#{version}"
  end
  version = gem_helper.send(:version)
  version_tag = gem_helper.version_tag
  
  namespace gem_name do
    desc "Build #{gem_name}-#{version}.gem into the pkg directory"
    task('build') { gem_helper.build_gem }

    desc "Build and install #{gem_name}-#{version}.gem into system gems"
    task('install') { gem_helper.install_gem }

    desc "Create tag #{version_tag} and build and push #{gem_name}-#{version}.gem to Rubygems"
    task('release') { gem_helper.release_gem }
  end
  
end

namespace :all do
  desc "Build all gems into the pkg directory"
  task 'build' => all_gems.map { |gem_name| "#{gem_name}:build" }

  desc "Build and install all gems into system gems"
  task 'install' => all_gems.map { |gem_name| "#{gem_name}:install" }
end
