require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe Trinidad::Extensions::OracleDbpoolWebAppExtension do
  include DbpoolExampleHelperMethods

  before(:each) do
    @defaults = { :jndi => 'jdbc/TestDB', :url => '' }
    @tomcat = mock_tomcat
    @context = build_context
  end

  it "sets the mssql driver name as a resource property" do
    extension = build_extension @defaults
    resource = extension.configure(@tomcat, @context)
    resource.get_property('driverClassName').should == 'oracle.jdbc.driver.OracleDriver'
  end

  it "adds the protocol if the url doesn't include it" do
    options = @defaults.merge :url => '@127.0.0.1:1433:without_protocol'
    extension = build_extension options
    resource = extension.configure(@tomcat, @context)
    resource.get_property('url').should == "jdbc:oracle:thin:#{options[:url]}"
  end

  def build_extension options
    Trinidad::Extensions::OracleDbpoolWebAppExtension.new(options)
  end
end
