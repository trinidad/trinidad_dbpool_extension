require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

module Trinidad
  module Extensions
    class StubDbpoolWebAppExtension < DbpoolWebAppExtension
      def driver_name
        'stub.Driver'
      end

      def protocol
        'jdbc:stub://'
      end
    end
  end
end

describe Trinidad::Extensions::StubDbpoolWebAppExtension do

  before(:each) do
    @defaults = { :jndi => 'jdbc/TestDB', :url => '' }
    @context = new_context; @tomcat = mock_tomcat
  end

  it "adds the resource to the tomcat standard context" do
    extension = new_webapp_extension :stub, @defaults
    extension.configure(@tomcat, @context)
    context_should_have_resource 'jdbc/TestDB'
  end

  it "adds properties to the resource" do
    options = @defaults.merge :maxIdle => 300
    extension = new_webapp_extension :stub, options
    resources = extension.configure(@tomcat, @context)
    resources.should be_only_and_have_property('maxIdle', '300')
  end

  it "adds the protocol if the url doesn't include it" do
    options = @defaults.merge :url => "localhost:3306/test_protocol"
    extension = new_webapp_extension :stub, options
    resources = extension.configure(@tomcat, @context)
    resources.should be_only_and_have_property('url', "jdbc:stub://#{options[:url]}")
  end

  it "allows for multiple pools per driver" do
    options = [@defaults, { :jndi => 'jdbc/TestDB2', :url => '' }]
    extension = new_webapp_extension :stub, options
    resources = extension.configure(@tomcat, @context)
    resources.should have(2).elements
    context_should_have_resource 'jdbc/TestDB'
    context_should_have_resource 'jdbc/TestDB2'
  end

  it "sets up jdbc pool's factory by default" do
    options = @defaults.merge :jndi => 'jdbc/TestDB', :url => 'jdbc:test://127.0.0.1:42/X'
    extension = new_webapp_extension :stub, options
    extension.configure(@tomcat, @context)

    resource = @context.naming_resources.find_resource('jdbc/TestDB')
    expect( resource ).to_not be nil

    expect( resource.get_property('factory') ).to eql 'org.apache.tomcat.jdbc.pool.DataSourceFactory'
    Java::JavaClass.for_name resource.get_property('factory')
  end

  it "sets resource type of data-source by default" do
    options = @defaults.merge :jndi => 'jdbc/TestDB'
    extension = new_webapp_extension :stub, options
    extension.configure(@tomcat, @context)

    resource = @context.naming_resources.find_resource('jdbc/TestDB')
    expect( resource.get_type ).to eql 'javax.sql.DataSource'
  end

  it "allows to override resource defaults" do
    options = @defaults.merge :jndi => 'jdbc/TestDB', :type => 'javax.sql.XADataSource', :auth => 'User'
    extension = new_webapp_extension :stub, options
    extension.configure(@tomcat, @context)

    resource = @context.naming_resources.find_resource('jdbc/TestDB')
    expect( resource.get_type ).to eql 'javax.sql.XADataSource'
    expect( resource.get_auth ).to eql 'User'
  end

  it "supports 'deprecated' dbcp pool" do
    options = @defaults.merge :jndi => 'jdbc/TestDB', :pool => 'dbcp'
    # expect( @context.logger ).to receive(:info).once
    extension = new_webapp_extension :stub, options
    extension.configure(@tomcat, @context)

    resource = @context.naming_resources.find_resource('jdbc/TestDB')
    expect( resource ).to_not be nil

    expect( resource.get_property('factory') ).to be nil
    Java::JavaClass.for_name 'org.apache.tomcat.dbcp.dbcp.ConnectionFactory'
  end

  def context_should_have_resource name
    @context.naming_resources.find_resource(name).should_not be_nil
  end

end
