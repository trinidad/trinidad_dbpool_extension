require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe Trinidad::Extensions::MysqlDbpoolWebAppExtension do
  before(:each) do
    @options = {
      :url => 'jdbc:mysql://localhost:3306/test',
      :jndi => 'jdbc/TestDB',
      :maxIdle => 300
    }
    @extension = Trinidad::Extensions::MysqlDbpoolWebAppExtension.new(@options)
    @context = Trinidad::Tomcat::StandardContext.new

    @tomcat = mock
    resource_context = mock
    naming = mock

    naming.stubs(:addResource)
    resource_context.stubs(:naming_resources).returns(naming)
    resource_context.stubs(:naming_resources=)
    @tomcat.stubs(:addContext).returns(resource_context)
  end

  it "uses the mysql jar driver" do
    @extension.driver_jar.should =~ /mysql-connector-java-.+jar$/
  end

  it "sets the mysql driver name as a resource property" do
    resource = configure_extension
    resource.getProperty('driverClassName').should == 'com.mysql.jdbc.Driver'
  end

  it "adds the resource to the tomcat standard context" do
    configure_extension
    @context.naming_resources.find_resource('jdbc/TestDB').should_not be_nil
  end

  it "adds properties to the resource" do
    resource = configure_extension
    resource.getProperty('maxIdle').should == '300'
  end

  it "adds the protocol if the url doesn't include it" do
    @options[:url] = "localhost:3306/test_protocol"
    extension = Trinidad::Extensions::MysqlDbpoolWebAppExtension.new(@options)
    resource = extension.configure(@tomcat, @context)
    resource.get_property('url').should == "jdbc:mysql://localhost:3306/test_protocol"
  end

  def configure_extension
    @extension.configure(@tomcat, @context)
  end
end
