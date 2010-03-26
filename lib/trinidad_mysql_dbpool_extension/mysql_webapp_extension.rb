module Trinidad
  module Extensions
    class MysqlDbpoolWebAppExtension < DbpoolWebAppExtension
      def driver_jar
        File.dirname(__FILE__) + '/../../trinidad-libs/mysql-connector-java-5.1.12-bin.jar'
      end

      def driver_name
        "com.mysql.jdbc.Driver"
      end

      def protocol
        "jdbc:mysql://"
      end
    end
  end
end
