module Trinidad
  module Extensions
    class GenericDbpoolWebAppExtension < DbpoolWebAppExtension
      def driver_name
        nil
      end

      def protocol
        'jdbc:'
      end
    end
  end
end
