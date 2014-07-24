require 'trinidad'

module Trinidad
  module Extensions
    class DbpoolWebAppExtension < WebAppExtension

      def configure(tomcat, context)
        case @options
        when Hash
          [ create_resource(tomcat, context, @options) ]
        when Array
          @options.map { |opts| create_resource tomcat, context, opts }
        end
      end

      protected

      def create_resource tomcat, context, options
        load_driver

        options[:driver] ||= options.delete(:driverName) ||
          options.delete(:driver_name) || self.driver_name

        if properties = options.delete(:properties) || connection_properties
          if properties.is_a?(String)
            options['connectionProperties'] ||= properties
          else # format: prop1=value1;prop2=value2
            url_params = properties.map { |key, value| "#{key}=#{value}" }
            options['connectionProperties'] ||= url_params.join(';')
          end
        end

        Trinidad::DBPool.create_resource(context, options, protocol)
      end

      def load_driver; end

      def connection_properties; end

    end
  end
end
