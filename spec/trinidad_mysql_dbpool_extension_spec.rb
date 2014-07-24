require File.expand_path(File.dirname(__FILE__) + '/spec_helper')
require 'trinidad_mysql_dbpool_extension'

describe Trinidad::Extensions::MysqlDbpoolWebAppExtension do

  before do
    @defaults = { :jndi => 'jdbc/TestDB', :url => '' }
    @tomcat = mock_tomcat
    @context = new_context
  end

  it "sets the mysql driver name as a resource property" do
    extension = new_webapp_extension :mysql, @defaults
    resources = extension.configure(@tomcat, @context)
    resources.should be_only_and_have_property('driverClassName', 'com.mysql.jdbc.Driver')
  end

  it "adds the protocol if the url doesn't include it" do
    options = @defaults.merge :url => 'localhost:3306/without_protocol'
    extension = new_webapp_extension :mysql, options
    resources = extension.configure(@tomcat, @context)
    resources.should be_only_and_have_property('url', "jdbc:mysql://#{options[:url]}")
  end

end