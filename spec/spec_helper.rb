require 'rspec'
require 'rspec/expectations'
begin
  require 'mocha/api'
rescue LoadError
  require 'mocha'
end

$LOAD_PATH.unshift(File.dirname(__FILE__))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))

require 'trinidad_dbpool'

module Trinidad
  module DBPool
    module SpecHelpers

      def mock_tomcat
        tomcat = mock('tomcat')
        resource_context = mock('resource_context')
        naming = mock('naming')
        naming.stubs(:addResource)
        resource_context.stubs(:naming_resources).returns(naming)
        resource_context.stubs(:naming_resources=)
        tomcat.stubs(:addContext).returns(resource_context)
        tomcat
      end

      def new_webapp_extension type, options
        name = "#{type.to_s.capitalize}DbpoolWebAppExtension"
        Trinidad::Extensions.const_get(name).new options
      end

      def new_context
        Trinidad::Tomcat::StandardContext.new
      end

    end
  end
end

RSpec.configure do |config|
  config.mock_with :mocha
  config.include Trinidad::DBPool::SpecHelpers
end

RSpec::Matchers.define :be_only_and_have_property do |property_name, expected|
  match do |actual|
    actual.should have(1).elements
    actual.first.get_property(property_name).should == expected
  end
end