class profile::zabbix::server inherits profile::zabbix{

  package { 'zabbix-server-mysql':
    ensure  => 'installed',
    require => Yumrepo['zabbix_repo'],
  }

  package { 'zabbix-web-mysql':
    ensure  => 'installed',
    require => Yumrepo['zabbix_repo'],
  }

  service { 'httpd':
    ensure => running,
    enable => true,
  }

  service { 'zabbix-server':
    ensure => running,
    enable => true,
  }


  mysql::db { 'zabbix':
    user           => 'zabbix',
    password       => 'Zabbix_2017',
    host           => 'localhost',
    charset        => 'utf8',
    collate        => 'utf8_bin',
    grant          => ['ALL'],
    sql            => '/usr/share/doc/zabbix-server-mysql-3.4.1/create.sql.gz',
    import_cat_cmd => 'zcat',
    import_timeout => 900,
    subscribe      => Package['zabbix-server-mysql'],

  }

  file { '/etc/httpd/conf.d/zabbix.conf':
    ensure  => file,
    content => template('profile/zabbix.conf.erb'),
    notify  => Service['httpd'],
  }

  file { '/etc/zabbix/web/zabbix.conf.php':
    ensure  => file,
    content => template('profile/zabbix.conf.php.erb'),
    notify  => Service['zabbix-server'],
  }

  file_line { 'DBPassword for zabbix-server':
    path    => '/etc/zabbix/zabbix_server.conf',
    line    => 'DBPassword=Zabbix_2017',
    require => Package['zabbix-server-mysql'],
  }

  -> file_line { 'StartPingers for zabbix-server':
    path => '/etc/zabbix/zabbix_server.conf',
    line => 'StartPingers=5',
  }

  -> file_line { 'CacheSize for zabbix-server':
    path => '/etc/zabbix/zabbix_server.conf',
    line => 'CacheSize=32M',
  }

}