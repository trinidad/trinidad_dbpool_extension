require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

module Trinidad
  module Extensions
    class GenericDbpoolWebAppExtension < DbpoolWebAppExtension
      def driver_name
        'generic.Driver'
      end

      def protocol
        'jdbc:generic://'
      end
    end
  end
end

describe Trinidad::Extensions::GenericDbpoolWebAppExtension do
  include DbpoolExampleHelperMethods

  before(:each) do
    @defaults = { :jndi => 'jdbc/TestDB', :url => '' }
    @context = build_context
    @tomcat = mock_tomcat
  end

  it "adds the resource to the tomcat standard context" do
    extension = build_extension @defaults
    extension.configure(@tomcat, @context)
    @context.naming_resources.find_resource('jdbc/TestDB').should_not be_nil
  end

  it "adds properties to the resource" do
    options = @defaults.merge :maxIdle => 300
    extension = build_extension options
    resource = extension.configure(@tomcat, @context)
    resource.get_property('maxIdle').should == '300'
  end

  it "adds the protocol if the url doesn't include it" do
    options = @defaults.merge :url => "localhost:3306/test_protocol"
    extension = build_extension options
    resource = extension.configure(@tomcat, @context)
    resource.get_property('url').should == "jdbc:generic://#{options[:url]}"
  end

  def build_extension options
    Trinidad::Extensions::GenericDbpoolWebAppExtension.new options
  end
end
