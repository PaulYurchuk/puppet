class profile::zabbix::agent inherits profile::zabbix{
  package { 'zabbix-agent':
    ensure  => 'installed',
    require => Yumrepo['zabbix_repo'],
  }

  file_line { 'DBPassword for zabbix-server':
    path    => '/etc/zabbix/zabbix_agentd.conf',
    #multiple => true,
    match   => '^Server=.*',
    line    => 'Server=192.168.56.200',
    require => Package['zabbix-agent'],
  }

  -> file_line { 'StartPingers for zabbix-server':
    path  => '/etc/zabbix/zabbix_agentd.conf',
    #multiple => true,
    match => '^ServerActive=.*',
    line  => 'ServerActive=192.168.56.200',
  }

}