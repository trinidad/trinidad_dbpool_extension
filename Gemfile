source 'https://rubygems.org'

gemspec :name => 'trinidad_dbpool'

gemspec :name => 'trinidad_generic_dbpool_extension'
gemspec :name => 'trinidad_mssql_dbpool_extension'
require 'java' if defined? JRUBY_VERSION
if defined? ENV_JAVA && ENV_JAVA['java.version'][0...3] <= '1.6'
gem 'jdbc-jtds', '~> 1.2.8', :require => nil
end
gemspec :name => 'trinidad_mysql_dbpool_extension'
gemspec :name => 'trinidad_postgresql_dbpool_extension'
gemspec :name => 'trinidad_sqlite_dbpool_extension'

gem 'trinidad', :require => nil

gem 'rake', :groups => [:development, :test], :require => nil
if defined? JRUBY_VERSION && JRUBY_VERSION < '1.7'
gem 'jruby-openssl', :group => :development, :require => nil
end