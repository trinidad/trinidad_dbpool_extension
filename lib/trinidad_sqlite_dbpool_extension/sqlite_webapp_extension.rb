module Trinidad
  module Extensions
    class SqliteDbpoolWebAppExtension < DbpoolWebAppExtension
      def driver_name
        'org.sqlite.JDBC'
      end

      def protocol
        'jdbc:sqlite://'
      end
    end
  end
end
