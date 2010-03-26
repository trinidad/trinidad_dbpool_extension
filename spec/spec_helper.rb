$LOAD_PATH.unshift(File.dirname(__FILE__))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'trinidad-libs'))

require 'trinidad_mysql_dbpool_extension'
require 'spec'

Spec::Runner.configure do |config| 
  config.mock_with :mocha
end
