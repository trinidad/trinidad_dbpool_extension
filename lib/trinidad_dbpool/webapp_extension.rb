require 'trinidad'

module Trinidad
  module Extensions
    class DbpoolWebAppExtension < WebAppExtension

      def configure(tomcat, context)
        case @options
        when Hash
          [create_resource(tomcat, context, @options)]
        when Array
          @options.map { |opts| create_resource tomcat, context, opts }
        end
      end

      protected

      def create_resource tomcat, context, options
        jndi, url = options.delete(:jndi), options.delete(:url)
        url = protocol + url unless %r{^#{protocol}} =~ url
        options[:url] = url

        resource_factory = options.key?(:factory) ? options.delete(:factory) :
          'org.apache.tomcat.jdbc.pool.DataSourceFactory'
        if pool = options.delete(:pool) # pool: dbcp (backwards compatibility)
          begin
            load File.expand_path("../../../trinidad-libs/tomcat-#{pool}.jar", __FILE__)
            resource_factory = nil
          rescue LoadError
            context.logger.warn "The `pool: #{pool}` option is not supported, please remove it"
          else
            context.logger.info "Using deprecated `pool: #{pool}` configuration option, consider removing it"
          end
        end

        load_driver

        driver_name = options.delete(:driver) || options.delete(:driverName) ||
                      self.driver_name

        # <Resource name="jdbc/MyDB"
        #           auth="Container"
        #           type="javax.sql.DataSource"
        #           url="jdbc:mysql://localhost:3306/mydb"
        #           driverClassName="com.mysql.jdbc.Driver"
        #           maxActive="100" maxIdle="30" maxWait="10000"
        #           username="root" password="secret" />
        resource = Trinidad::Tomcat::ContextResource.new
        resource.set_auth(options.delete(:auth)) if options.key?(:auth)
        resource.set_description(options.delete(:description)) if options.key?(:description)
        resource.set_name(jndi)
        resource.set_type(options.delete(:type) || 'javax.sql.DataSource')
        resource.set_property('factory', resource_factory) if resource_factory
        resource.set_property('driverClassName', driver_name)
        options.each { |key, value| resource.set_property(key.to_s, value.to_s) }

        context.naming_resources.add_resource(resource)
        context.naming_resources = resource.naming_resources

        resource
      end

      def load_driver; end

    end
  end
end
