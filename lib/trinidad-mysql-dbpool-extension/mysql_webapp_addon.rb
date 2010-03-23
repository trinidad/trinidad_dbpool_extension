module Trinidad
  class MysqlDbpoolWebAppAddon < DbpoolWebAppAddon
    def self.configure(*args)
      puts 'Configuring Mysql connection pool'
      args = args.flatten
      configure_internal(args[0], args[1], args[2])
    end

    def self.configure_internal(app_context, class_loader, options)
      resource = DbpoolWebAppAddon.configure_internal(app_context, options)

      mysql_driver_jar = File.dirname(__FILE__) + '/../../trinidad-libs/mysql-connector-java-5.1.12-bin.jar'
      class_loader.addURL(java.io.File.new(mysql_driver_jar).to_url)

      resource.setProperty("driverClassName", "com.mysql.jdbc.Driver")

      app_context.naming_resources.add_resource(resource)
    end
  end
end
