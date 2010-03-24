require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe Trinidad::MysqlDbpoolWebAppAddon do
  before(:each) do
    @addon = Trinidad::MysqlDbpoolWebAppAddon.new
    @class_loader = org.jruby.util.JRubyClassLoader.new(JRuby.runtime.jruby_class_loader)
    @context = Trinidad::Tomcat::StandardContext.new

    @opts = {
      'name' => 'jdbc/TestDB'
    }
  end

  it "uses the mysql jar driver" do
    @addon.driver_jar.should =~ /mysql-connector-java-.+jar$/
  end

  it "sets the mysql driver name as a resource property" do
    resource = configure_addon
    resource.getProperty('driverClassName').should == 'com.mysql.jdbc.Driver'
  end

  it "loads the jar into the jruby's class loader" do
    configure_addon
    @class_loader.getURLs().should have(1).resource
  end

  it "adds the resource to the tomcat standard context" do
    configure_addon
    @context.naming_resources.find_resource('jdbc/TestDB').should_not be_nil
  end

  it "adds properties to the resource" do
    @opts['maxIdle'] = 300
    resource = configure_addon
    resource.getProperty('maxIdle').should == '300'
  end

  def configure_addon
    @addon.configure(@context, @class_loader, @opts)
  end
end
