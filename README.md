# Trinidad Database Pool

A bunch of Trinidad extensions to support database connection pooling on top of
the underlying Apache Tomcat container (using Tomcat's JDBC Connection Pool).

Please note, that such pools are usually configured as "global" and thus
shareable by multiple applications deployed on to of the Trinidad server.

Also most Java issues caused by JDBC drivers packaged with the application (e.g.
`java.lang.UnsatisfiedLinkError` with SQLite3's JDBC driver) that JRuby inherits
should go away when database connections are managed externally.

http://tomcat.apache.org/tomcat-7.0-doc/jdbc-pool.html

## Available Pools

* MySQL (trinidad_mysql_dbpool_extension)
* PostgreSQL (trinidad_postgresql_dbpool_extension)
* SQLite (trinidad_sqlite_dbpool_extension)
* MS-SQL (trinidad_mssql_dbpool_extension) using (unofficial) jTDS driver
* Generic (trinidad_generic_dbpool_extension) in case your DB ain't supported

## Usage

* Install the gem e.g. `jruby -S gem install trinidad_mysql_dbpool_extension`
* Configure the pool with Trinidad's configuration file e.g. :

```yml
  web_apps:
    default:
      extensions:
        mysql_dbpool:                   # EXTENSION NAME AS KEY
          jndi: 'jdbc/MySampleDB'       # name (linked with database.yml)
          url: 'localhost:3306/sample'  # database URL (or full jdbc: URL)
          username: root
          password: root
          maxActive:  100  # maximum number of connections managed by the pool
          initialSize: 10  # initial number of connections created in the pool
          maxWait:  10000  # ms the pool waits for a connection to be returned
```

**jndi**, **url** are mandatory (as well **username** and **password** if your
database server + driver requires authentication), while other supported
configuration options might be found here in Tomcat's JDBC pool documentation :

http://tomcat.apache.org/tomcat-7.0-doc/jdbc-pool.html#Common_Attributes

**NOTE:** starting version 0.7 we switched to using Tomcat's JDBC pool which
is simpler and more performant pool designed specifically for Tomcat/Trinidad.

If you insist on using [DBCP](http://commons.apache.org/dbcp/configuration.html)
set the (deprecated) *pool: dbcp* option along side your pool configuration ...

If you happen to be using *SQLite* on production you'll need an absolute path :

```yml
  extensions:
    sqlite_dbpool:
      jndi: jdbc/FileDB
      url: <%= File.expand_path('db/production.db') %>
```

* Configure the (Rails) application to use JNDI with *config/database.yml*

```yml
production:
  adapter: mysql
  jndi: java:/comp/env/jdbc/MySampleDB
  # (Java) JDBC driver class name is detected for built-in adapters that
  # activerecord-jdbc-adapter supports, specify for a "generic" adapter
  # driver: com.mysql.jdbc.Driver
```

do not forget to delete **pool** setup part since there's no need for it ...

## Generic Pool

If there's no "official" pool for your database, or would like to use a
different version of a JDBC driver for a supported Trinidad pool, this allows
you to completely customize a pool.

NOTE: You will need a JDBC driver for your database, check the driver DB if
unsure about how to get one http://developers.sun.com/product/jdbc/drivers

Sample configuration for a DB2 database :

```yml
---
  extensions:
    generic_dbpool:                          # EXTENSION NAME AS KEY
      jndi: 'jdbc/MyDB'                      # JNDI name
      url: 'jdbc:db2://127.0.0.1:50000/MYDB' # specify full jdbc: URL
      username: 'mydb'                       # database username
      password: 'pass'                       # database password
      driverPath: '/opt/IBM/DB2/db2jcc4.jar' # leave out if on class-path
      driverName: com.ibm.db2.jcc.DB2Driver  # resolved from driverPath jar
```

Beyond standard configuration options there's 2 specific options here :

* **driverPath** should be a path to your JDBC driver archive, might leave that
  out but make sure it's on the (shared) class-path for each and every deployed
  application that requires it. You might specify multiple jars using the
  `Dir.glob` syntax or by separating paths using the `:` separator.

  Also in case *driverPath* is omitted you'll need to specify a *driverName* !

* **driverName** the class name implementing the JDBC driver interface, if
  you're not sure check the .jar for a META-INF/services/java.sql.Driver file.
  If present that file contains the class-name and you might leave *driverName*
  blank if you specified the jar path using *driverPath* but you're going still
  going to need the driver name in your *database.yml*

## Copyright

Copyright (c) 2014 [Team Trinidad](https://github.com/trinidad).
See LICENSE (http://en.wikipedia.org/wiki/MIT_License) for details.
