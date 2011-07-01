module Trinidad
  module Extensions
    class PostgresqlDbpoolWebAppExtension < DbpoolWebAppExtension
      def driver_name
        'org.postgresql.Driver'
      end

      def protocol
        'jdbc:postgresql://'
      end
    end
  end
end
