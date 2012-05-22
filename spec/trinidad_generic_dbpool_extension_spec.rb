require File.expand_path(File.dirname(__FILE__) + '/spec_helper')
require 'trinidad_generic_dbpool_extension'

describe Trinidad::Extensions::GenericDbpoolWebAppExtension do
  include DbpoolExampleHelperMethods

  before(:each) do
    @defaults = { :jndi => 'jdbc/TestDB', :url => '' }
    @tomcat = mock_tomcat
    @context = build_context
  end

  it "sets the generic driver name as a resource property" do
    extension = build_extension @defaults
    resources = extension.configure(@tomcat, @context)
    resources.should be_only_and_have_property('driverClassName', nil)
  end

  it "adds the protocol if the url doesn't include it" do
    url = 'localhost:3306/without_protocol'
    options = @defaults.merge :url => url
    extension = build_extension options
    resources = extension.configure(@tomcat, @context)
    resources.should be_only_and_have_property('url', "jdbc:#{url}")
  end

  def build_extension options
    Trinidad::Extensions::GenericDbpoolWebAppExtension.new options
  end
end
