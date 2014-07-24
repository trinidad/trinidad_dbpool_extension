require 'java'
require 'trinidad/jars'
load File.expand_path('../../trinidad-libs/tomcat-jdbc.jar', __FILE__)

module Trinidad
  module DBPool
    class << self

      def create_resource(context, options, protocol = nil)
        jndi, url = options.delete(:jndi), options.delete(:url)
        if ! url.start_with?('jdbc:') && protocol
          url = "#{protocol}#{url}" unless url.start_with?(protocol)
        end

        resource_factory = options.key?(:factory) ? options.delete(:factory) :
          'org.apache.tomcat.jdbc.pool.DataSourceFactory'
        if ( pool = options.delete(:pool) ) && pool.to_s != 'jdbc' # pool: 'dbcp'
          begin
            load File.expand_path("../../trinidad-libs/tomcat-#{pool}.jar", __FILE__)
            resource_factory = nil
          rescue LoadError
            context.logger.warn "The `pool: #{pool}` option is not supported, please remove it"
          else
            context.logger.info "Using deprecated `pool: #{pool}` configuration option, consider removing it"
          end
        end

        driver = options.delete(:driver) || options.delete(:driverName) || options.delete(:driver_name)

        context.logger.debug "Using JDBC URL: #{url.inspect} for #{jndi}"

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
        resource.set_property('driverClassName', driver)
        resource.set_property('url', url)
        camelizer = supported_properties_camelizer
        options.each do |key, value|
          resource.set_property(camelizer[key.to_s], value.to_s)
        end

        yield(resource) if block_given?

        context.naming_resources.add_resource(resource)
        context.naming_resources = resource.naming_resources

        resource
      end

      private

      def supported_properties_camelizer
        hash = Hash.new { |hash, key| simple_camelize(key) }

        # Common Attributes :

        hash['username'] = 'username'
        hash['password'] = 'password'
        hash['driver_class_name'] = 'driverClassName'

        hash['default_auto_commit'] = 'defaultAutoCommit'
        hash['default_read_only'] = 'defaultReadOnly'
        hash['default_transaction_isolation'] = 'defaultTransactionIsolation'
        hash['default_catalog'] = 'defaultCatalog'

        hash['max_active'] = 'maxActive'
        hash['max_idle'] = 'maxIdle'
        hash['min_idle'] = 'minIdle'
        hash['initial_size'] = 'initialSize'
        hash['max_wait'] = 'maxWait'

        hash['test_on_borrow'] = 'testOnBorrow'
        hash['test_on_return'] = 'testOnReturn'
        hash['test_while_idle'] = 'testWhileIdle'

        hash['validation_query'] = 'validationQuery'
        hash['validation_query_timeout'] = 'validationQueryTimeout'

        #

        hash['log_abandoned'] = 'logAbandoned'
        hash['remove_abandoned'] = 'removeAbandoned'
        hash['remove_abandoned_timeout'] = 'removeAbandonedTimeout'

        hash['connection_properties'] = 'connectionProperties'

        # Tomcat JDBC pool only :

        hash['init_sql'] = 'initSQL'
        hash['validation_interval'] = 'validationInterval'
        hash['jmx_enabled'] = 'jmxEnabled'
        hash['fair_queue'] = 'fairQueue'
        hash['abandon_when_percentage_full'] = 'abandonWhenPercentageFull'

        hash['max_age'] = 'maxAge'
        hash['suspect_timeout'] = 'suspectTimeout'
        hash['rollback_on_return'] = 'rollbackOnReturn'
        hash['commit_on_return'] = 'commitOnReturn'
        hash['alternate_username_allowed'] = 'alternateUsernameAllowed'

        hash
      end

      def simple_camelize(string)
        return string unless string.index('_')
        string.gsub(/_([a-z\d]*)/i) { $1.capitalize }
      end

    end
  end
end