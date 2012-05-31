require 'pathname'

module Trinidad
  module Extensions
    class GenericDbpoolWebAppExtension < DbpoolWebAppExtension
      def driver_name
        if driver_path = @driver_path
          unless File.exist?(driver_path)
            driver_path = "#{driver_path}.jar" if driver_path[-4..-1] != '.jar'
          end
          driver_path = Pathname.new(driver_path).realpath.to_s
          if File.exist?(driver_path)
            url = java.net.URL.new "jar:file://#{driver_path}!/META-INF/services/java.sql.Driver"
            begin
              reader = java.io.InputStreamReader.new( url.openStream )
              return java.io.BufferedReader.new( reader ).readLine
            rescue java.io.FileNotFoundException
            end
          end
        end
        nil
      end

      def protocol
        'jdbc:'
      end
      
      protected
      def create_resource tomcat, app_context, options
        @driver_path = options.delete(:driverPath)
        require @driver_path if @driver_path
        super
      end
    end
  end
end
