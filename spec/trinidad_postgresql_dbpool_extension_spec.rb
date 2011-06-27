require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe Trinidad::Extensions::PostgresqlDbpoolWebAppExtension do
  include DbpoolExampleHelperMethods

  before(:each) do
    @defaults = { :jndi => 'jdbc/TestDB', :url => '' }
    @tomcat = mock_tomcat
    @context = build_context
  end

  it "sets the postgresql driver name as a resource property" do
    extension = build_extension @defaults
    resource = extension.configure(@tomcat, @context)
    resource.get_property('driverClassName').should == 'org.postgresql.Driver'
  end

  it "adds the protocol if the url doesn't include it" do
    options = @defaults.merge :url => 'localhost:3306/without_protocol'
    extension = build_extension options
    resource = extension.configure(@tomcat, @context)
    resource.get_property('url').should == "jdbc:postgresql://#{options[:url]}"
  end

  def build_extension options
    Trinidad::Extensions::PostgresqlDbpoolWebAppExtension.new options
  end
end
