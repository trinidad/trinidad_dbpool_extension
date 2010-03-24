def unshift(path)
  $:.unshift(File.dirname(__FILE__)) unless
    $:.include?(File.dirname(__FILE__)) || $:.include?(File.expand_path(File.dirname(__FILE__)))
end

unshift(File.dirname(__FILE__))
unshift(File.dirname(__FILE__) + '/../trinidad-libs')

require 'trinidad-dbpool'

require 'mysql-connector-java-5.1.12-bin'

require 'trinidad-mysql-dbpool-extension/mysql_webapp_addon'
