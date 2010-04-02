module Trinidad
  module Extensions
    class MysqlDbpoolWebAppExtension < DbpoolWebAppExtension
      def driver_name
        'com.mysql.jdbc.Driver'
      end

      def protocol
        'jdbc:mysql://'
      end
    end
  end
end
