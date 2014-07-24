require File.expand_path(File.dirname(__FILE__) + '/spec_helper')
require 'trinidad_postgresql_dbpool_extension'

describe Trinidad::Extensions::PostgresqlDbpoolWebAppExtension do

  before do
    @defaults = { :jndi => 'jdbc/TestDB', :url => '' }
    @tomcat = mock_tomcat
    @context = new_context
  end

  it "sets the postgresql driver name as a resource property" do
    extension = new_webapp_extension :postgresql, @defaults
    resources = extension.configure(@tomcat, @context)
    resources.should be_only_and_have_property('driverClassName', 'org.postgresql.Driver')
  end

  it "adds the protocol if the url doesn't include it" do
    options = @defaults.merge :url => 'localhost:3306/without_protocol'
    extension = new_webapp_extension :postgresql, options
    resources = extension.configure(@tomcat, @context)
    resources.should be_only_and_have_property('url', "jdbc:postgresql://#{options[:url]}")
  end

end