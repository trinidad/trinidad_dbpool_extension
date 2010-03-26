def unshift(path)
  $:.unshift(path) unless
    $:.include?(path) || $:.include?(File.expand_path(path))
end

unshift(File.dirname(__FILE__))
unshift(File.dirname(__FILE__) + '/../trinidad-libs')

require 'trinidad_dbpool'
require 'mysql-connector-java-5.1.12-bin'
require 'trinidad_mysql_dbpool_extension/mysql_webapp_extension'
