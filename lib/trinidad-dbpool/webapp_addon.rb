module Trinidad
  class DbpoolWebAppAddon
    def self.configure_internal(app_context, options)
      options[:type] = "javax.sql.DataSource"

      resource = Trinidad::Tomcat::ContextResource.new
      resource.setAuth("Container")
      resource.setName(options.delete('name'))
      resource.setDescription(options.delete('description')) if options['description']
      options.each do |key, value|
        resource.setProperty(key.to_s, value.to_s)
      end

      resource
    end
  end
end
