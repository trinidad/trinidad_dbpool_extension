module Trinidad
  class MysqlDbpoolWebAppAddon < DbpoolWebAppAddon
    def driver_jar
      File.dirname(__FILE__) + '/../../trinidad-libs/mysql-connector-java-5.1.12-bin.jar'
    end

    def driver_name
      "com.mysql.jdbc.Driver"
    end
  end
end
