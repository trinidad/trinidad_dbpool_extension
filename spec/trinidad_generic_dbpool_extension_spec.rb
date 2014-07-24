require File.expand_path(File.dirname(__FILE__) + '/spec_helper')
require 'trinidad_generic_dbpool_extension'

describe Trinidad::Extensions::GenericDbpoolWebAppExtension do

  before do
    @defaults = { :jndi => 'jdbc/TestDB', :url => '' }
    @tomcat = mock_tomcat
    @context = new_context
  end

  it "sets the generic driver name as a resource property" do
    extension = new_webapp_extension :generic, @defaults
    resources = extension.configure(@tomcat, @context)
    resources.should be_only_and_have_property('driverClassName', nil)
  end

  it "adds the protocol if the url doesn't include it" do
    url = 'localhost:3306/without_protocol'
    options = @defaults.merge :url => url
    extension = new_webapp_extension :generic, options
    resources = extension.configure(@tomcat, @context)
    resources.should be_only_and_have_property('url', "jdbc:#{url}")
  end

  it "resolves driver name from jar path if specified" do
    extension = new_webapp_extension :generic, @defaults.merge(:driverPath => File.join(File.dirname(__FILE__), 'dummy-driver'))
    resources = extension.configure(@tomcat, @context)
    extension.driver_name.should == 'org.trinidad.jdbc.DummyDriver'
    resources.should be_only_and_have_property('driverClassName', 'org.trinidad.jdbc.DummyDriver')
  end

  it "resolves driver name from jar path with multiple paths" do
    extension = new_webapp_extension :generic, @defaults.merge(:driver_path => 'trinidad-libs/tomcat-dbcp.jar:spec/dummy-driver.jar')
    extension.configure(@tomcat, @context)
    extension.driver_name.should == 'org.trinidad.jdbc.DummyDriver'
  end

  it "specified path to driver jar classes are loadable" do
    extension = new_webapp_extension :generic, @defaults.merge(:driverPath => File.join(File.dirname(__FILE__), 'dummy-driver.jar'))
    resources = extension.configure(@tomcat, @context)
    lambda { org.trinidad.jdbc.DummyDriver }.should_not raise_error
  end

  it "supports glob-ing and multiple paths in driverPath" do
    extension = new_webapp_extension :generic, @defaults.merge(:driver_path => 'spec/dummy-driver:spec/mysql*.jar')
    extension.configure(@tomcat, @context)
    extension.driver_path.should == ["spec/dummy-driver.jar", "spec/mysql-connector-java-5.1.22.jar"]
  end

end