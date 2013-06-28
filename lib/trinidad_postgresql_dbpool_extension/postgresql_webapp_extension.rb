module Trinidad
  module Extensions
    class PostgresqlDbpoolWebAppExtension < DbpoolWebAppExtension

      def driver_name
        defined?(Jdbc::Postgres.driver_name) ? Jdbc::Postgres.driver_name :
          'org.postgresql.Driver'
      end

      def protocol
        'jdbc:postgresql://'
      end

      def load_driver
        require 'jdbc/postgres'
        Jdbc::Postgres.load_driver if defined?(Jdbc::Postgres.load_driver)
      end

    end
  end
end