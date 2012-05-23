require File.expand_path(File.dirname(__FILE__) + '/spec_helper')
require 'trinidad_mssql_dbpool_extension'

describe Trinidad::Extensions::MssqlDbpoolWebAppExtension do
  include DbpoolExampleHelperMethods

  before(:each) do
    @defaults = { :jndi => 'jdbc/TestDB', :url => '' }
    @tomcat = mock_tomcat
    @context = build_context
  end

  it "sets the mssql driver name as a resource property" do
    extension = build_extension @defaults
    resources = extension.configure(@tomcat, @context)
    resources.should be_only_and_have_property('driverClassName', 'net.sourceforge.jtds.jdbc.Driver')
  end

  it "adds the protocol if the url doesn't include it" do
    options = @defaults.merge :url => '127.0.0.1:1433/without_protocol'
    extension = build_extension options
    resources = extension.configure(@tomcat, @context)
    resources.should be_only_and_have_property('url', "jdbc:jtds:sqlserver://#{options[:url]}")
  end

  def build_extension options
    Trinidad::Extensions::MssqlDbpoolWebAppExtension.new(options)
  end
end
