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
      
      protected
      def create_resource tomcat, app_context, options
        jndi, url = options.delete(:jndi), options.delete(:url)
        url = protocol + url unless %r{^#{protocol}} =~ url
        options[:url] = url
        
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
        resource.set_auth(options.delete(:auth)) if options.has_key?(:auth)
        resource.set_description(options.delete(:description)) if options.has_key?(:description)
        resource.set_name(jndi)
        resource.set_type('javax.sql.DataSource')

        options.each { |key, value| resource.set_property(key.to_s, value.to_s) }
        resource.set_property('driverClassName', driver_name)

        app_context.naming_resources.add_resource(resource)
        app_context.naming_resources = resource.naming_resources

        resource
      end
    end
  end
end
