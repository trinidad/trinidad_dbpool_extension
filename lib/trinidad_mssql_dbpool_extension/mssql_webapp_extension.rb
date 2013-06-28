module Trinidad
  module Extensions
    class MssqlDbpoolWebAppExtension < DbpoolWebAppExtension

      def driver_name
        defined?(Jdbc::JTDS.driver_name) ? Jdbc::JTDS.driver_name :
          'net.sourceforge.jtds.jdbc.Driver'
      end

      def protocol
        'jdbc:jtds:sqlserver://'
      end

      def load_driver
        require 'jdbc/jtds'
        # NOTE: the adapter has only support for working with the
        # open-source jTDS driver (won't work with MS's driver) !
        Jdbc::JTDS.load_driver if defined?(Jdbc::JTDS.load_driver)
      end

    end
  end
end