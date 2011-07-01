module Trinidad
  module Extensions
    class MssqlDbpoolWebAppExtension < DbpoolWebAppExtension
      def driver_name
        'net.sourceforge.jtds.jdbc.Driver'
      end

      def protocol
        'jdbc:jtds:sqlserver://'
      end
    end
  end
end
