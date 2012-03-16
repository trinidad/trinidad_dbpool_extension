module Trinidad
  module Extensions
    class DbpoolWebAppExtension < WebAppExtension
      def configure(tomcat, app_context)
        case @options
        when Hash
          [create_resource(tomcat, app_context, @options)]
        when Array
          @options.map { |opts| create_resource tomcat, app_context, opts }
        end
      end

      private
      def create_resource tomcat, app_context, opts
        jndi = opts.delete(:jndi)
        url = opts.delete(:url)
        url = protocol + url unless %r{^#{protocol}} =~ url
        opts[:url] = url
                
        driver_name = opts.delete(:driver) || self.driver_name

        resource = Trinidad::Tomcat::ContextResource.new
        resource.set_auth(opts.delete(:auth)) if opts.key?(:auth)
        resource.set_name(jndi)
        resource.set_type('javax.sql.DataSource')
        resource.set_description(opts.delete(:description)) if opts.key?(:description)

        opts.each { |key, value| resource.set_property(key.to_s, value.to_s) }
        resource.set_property('driverClassName', driver_name)

        app_context.naming_resources.add_resource(resource)
        app_context.naming_resources = resource.naming_resources

        resource
      end
    end
  end
end
