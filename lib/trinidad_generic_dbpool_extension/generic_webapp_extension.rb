module Trinidad
  module Extensions
    class GenericDbpoolWebAppExtension < DbpoolWebAppExtension

      PATH_SEPARATOR = java.io.File::pathSeparator

      def driver_path(first = nil)
        path = @driver_path || []
        first ? path.first : path
      end

      def driver_path=(path)
        path = ( path || '' ).split(PATH_SEPARATOR)
        path.map! do |jar|
          jars = Dir.glob(jar)
          if jars.empty? # normalize .jar ext
            jar = "#{jar}.jar" if jar[-4..-1] != '.jar'
            jar
          else
            jars
          end
        end
        path.flatten!
        @driver_path = path
      end

      def driver_name
        return @driver_name if defined? @driver_name
        driver_path.find do |path|
          path = java.io.File.new(path).absolute_path
          if File.exist?(path)
            url = java.net.URL.new "jar:file://#{path}!/META-INF/services/java.sql.Driver"
            begin
              reader = java.io.InputStreamReader.new( url.openStream )
              return @driver_name = java.io.BufferedReader.new( reader ).readLine
            rescue java.io.FileNotFoundException
              false
            end
          end
        end
        @driver_name = nil
      end

      def protocol
        'jdbc:'
      end

      protected

      def create_resource tomcat, app_context, options
        path = options.delete(:driverPath) || options.delete(:driver_path)
        self.driver_path = path if path
        if path && driver_path.empty?
          warn "no driver matched with specified :driverPath = #{path.inspect}"
        end
        super
      end

      def load_driver
        driver_path.each { |jar| load jar }
      end

    end
  end
end