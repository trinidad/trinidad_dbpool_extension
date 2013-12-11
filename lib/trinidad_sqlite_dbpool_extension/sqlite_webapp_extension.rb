require 'trinidad_dbpool/webapp_extension'

module Trinidad
  module Extensions
    class SqliteDbpoolWebAppExtension < DbpoolWebAppExtension

      def driver_name
        defined?(Jdbc::SQLite3.driver_name) ? Jdbc::SQLite3.driver_name :
          'org.sqlite.JDBC'
      end

      def protocol
        'jdbc:sqlite://'
      end

      def load_driver
        require 'jdbc/sqlite3'
        Jdbc::SQLite3.load_driver if defined?(Jdbc::SQLite3.load_driver)
      end

    end
  end
end