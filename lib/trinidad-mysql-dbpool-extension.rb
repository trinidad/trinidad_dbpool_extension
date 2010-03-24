def unshift(path)
  $:.unshift(path) unless
    $:.include?(path) || $:.include?(File.expand_path(path))
end

unshift(File.dirname(__FILE__))
unshift(File.dirname(__FILE__) + '/../trinidad-libs')

require 'trinidad-dbpool'

require 'mysql-connector-java-5.1.12-bin'

require 'trinidad-mysql-dbpool-extension/mysql_webapp_addon'
