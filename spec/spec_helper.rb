require 'rubygems'

require 'rspec'
require 'rspec/expectations'
require 'mocha'

$LOAD_PATH.unshift(File.dirname(__FILE__))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'trinidad-libs'))

require 'trinidad_dbpool'

RSpec.configure do |config|
  config.mock_with :mocha
end

RSpec::Matchers.define :be_only_and_have_property do |property_name, expected|
  match do |actual|
    actual.should have(1).elements
    actual.first.get_property(property_name).should == expected
  end
end

module DbpoolExampleHelperMethods
  def mock_tomcat
    tomcat = mock
    resource_context = mock
    naming = mock
    naming.stubs(:addResource)
    resource_context.stubs(:naming_resources).returns(naming)
    resource_context.stubs(:naming_resources=)
    tomcat.stubs(:addContext).returns(resource_context)
    tomcat
  end

  def build_context
    Trinidad::Tomcat::StandardContext.new
  end
end
