require 'rubygems'
require 'rake'

def build(gem)
  mkdir_p 'pkg'
  sh "gem build #{gem}.gemspec"
  mv Dir["#{gem}*.gem"].last, 'pkg'
end

def release(gem, version = nil)
  unless `git branch` =~ /^\* master$/
    raise "must be on master to release !"
  end
  
  if version
    unless gem_file = Dir.glob("pkg/#{gem}-#{version}.gem").first
      raise "#{gem}-#{version}.gem not build !"
    end
  else
    unless gem_file = Dir.glob("pkg/#{gem}*").sort.last
      raise "#{gem}*.gem not build !"
    end
    unless match = gem_file.match(/.*?\-(\d\.\d\.\d)\.gem/)
      raise "version number not matched from: #{gem_file}"
    end
    version = match[1]
  end
  
  sh "git tag #{gem}-#{version}"
  sh "git push origin master --tags"
  sh "gem push #{gem_file}"
end

all_gems = %W{ dbpool mysql_dbpool_extension postgresql_dbpool_extension mssql_dbpool_extension oracle_dbpool_extension }
all_gems.map! { |gem| "trinidad_#{gem}" }
all_gems.each do |gem_name|
  namespace gem_name do
    desc "Build the #{gem_name} gem"
    task :build do
      build(gem_name)
    end
    desc "Release the #{gem_name} gem"
    task :release => :build do
      release(gem_name)
    end
  end
end

{
  :build => 'Build all connection pool gems', 
  :release => 'Release all connection pool gems'
}.each do |t, d|
  desc d
  task t => all_gems.map { |name| "#{name}:#{t}" } # e.g. mysql_dbpool:build
end

desc "Clear out all built .gem files"
task :clear do
  FileUtils.rm Dir["*.gem"]
  FileUtils.rm_r Dir["pkg/*"] if File.exist?("pkg")
end

require 'rspec/core/rake_task'
RSpec::Core::RakeTask.new(:spec) do |spec|
  spec.rspec_opts = ['--color', "--format documentation"]
end

task :default => :spec
