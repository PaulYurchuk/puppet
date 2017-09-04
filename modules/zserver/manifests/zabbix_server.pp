class zserver::zabbix_server(

  $userdb = '',
  $passdb = '',
  $namedb = '',
  $filldb = '',
) {

  Package {
    ensure => 'installed',
    require => Class['zserver::repo'],
  }

  package { 'zabbix-server-mysql': }
  package { 'zabbix-web-mysql': }

  mysql::db { $namedb:
    ensure         => 'present',
    user           => $userdb,
    password       => $passdb,
    host           => 'localhost',
    charset        => 'utf8',
    collate        => 'utf8_bin',
    grant          => ['ALL'],
    sql            => $filldb,
    import_cat_cmd => 'zcat',
    import_timeout => 600,
    subscribe      => Package['zabbix-server-mysql'],
  }

  file { '/etc/httpd/conf.d/zabbix.conf':
    ensure  => present,
    content => template('zabbix_server/zabbix.conf.erb'),
    require => Package['zabbix-web-mysql'],
    notify  => Service['httpd'],
  }

  file { '/etc/zabbix/zabbix_server.conf':
    ensure  => present,
    content => template('zabbix_server/zabbix_server.conf.erb'),
    require => Package['zabbix-server-mysql'],
    notify  => Class['apache::service'],
  }

  file { '/etc/zabbix/web/zabbix.conf.php':
    ensure  => present,
    content => template('zabbix_server/zabbix.conf.php.erb'),
    require => File['/etc/zabbix/zabbix_server.conf'],
    notify  => Service['zabbix-server'],
  }

  service { 'zabbix-server':
    ensure  => running,
    enable  => true,
    require => File['/etc/zabbix/web/zabbix.conf.php'],
  }

}