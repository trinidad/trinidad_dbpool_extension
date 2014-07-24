require File.expand_path(File.dirname(__FILE__) + '/spec_helper')
require 'trinidad_mssql_dbpool_extension'

describe Trinidad::Extensions::MssqlDbpoolWebAppExtension do

  before do
    @defaults = { :jndi => 'jdbc/TestDB', :url => '' }
    @tomcat = mock_tomcat
    @context = new_context
  end

  it "sets the mssql driver name as a resource property" do
    extension = new_webapp_extension :mssql,  @defaults
    resources = extension.configure(@tomcat, @context)
    resources.should be_only_and_have_property('driverClassName', 'net.sourceforge.jtds.jdbc.Driver')
  end

  it "adds the protocol if the url doesn't include it" do
    options = @defaults.merge :url => '127.0.0.1:1433/without_protocol'
    extension = new_webapp_extension :mssql, options
    resources = extension.configure(@tomcat, @context)
    resources.should be_only_and_have_property('url', "jdbc:jtds:sqlserver://#{options[:url]}")
  end

end