require 'trinidad_dbpool/webapp_extension'

module Trinidad
  module Extensions
    class MysqlDbpoolWebAppExtension < DbpoolWebAppExtension

      def driver_name
        defined?(Jdbc::MySQL.driver_name) ? Jdbc::MySQL.driver_name :
          'com.mysql.jdbc.Driver'
      end

      def protocol
        'jdbc:mysql://'
      end

      def load_driver
        require 'jdbc/mysql'
        Jdbc::MySQL.load_driver if defined?(Jdbc::MySQL.load_driver)
      end

    end
  end
end