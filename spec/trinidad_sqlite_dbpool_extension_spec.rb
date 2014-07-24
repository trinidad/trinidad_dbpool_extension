require File.expand_path(File.dirname(__FILE__) + '/spec_helper')
require 'trinidad_sqlite_dbpool_extension'

describe Trinidad::Extensions::SqliteDbpoolWebAppExtension do

  before do
    @defaults = { :jndi => 'jdbc/HelloDB', :url => '' }
    @tomcat = mock_tomcat
    @context = new_context
  end

  it "sets the sqlite driver name as a resource property" do
    extension = new_webapp_extension :sqlite, @defaults
    resources = extension.configure(@tomcat, @context)
    resources.should be_only_and_have_property('driverClassName', 'org.sqlite.JDBC')
  end

  it "adds the protocol if the url doesn't include it" do
    options = @defaults.merge :url => 'db/production/hello.db'
    extension = new_webapp_extension :sqlite, options
    resources = extension.configure(@tomcat, @context)
    resources.should be_only_and_have_property('url', "jdbc:sqlite://#{options[:url]}")
  end

end