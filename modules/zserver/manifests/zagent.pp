class zserver::zagent( 
 $ip_servagent = '192.168.56.200',
){
  yumrepo { 'zabbix':
    baseurl  => 'http://repo.zabbix.com/zabbix/3.4/rhel/7/x86_64', 
    gpgkey   => 'https://repo.zabbix.com/RPM-GPG-KEY-ZABBIX-A14FE591',
    enabled  => 1,
    gpgcheck => 1
  }

  package { 'zabbix-agent':
    ensure  => installed,
#    require => Class['zabbix_server::repo'],
  }

  file { '/etc/zabbix/zabbix_agentd.conf':
    ensure  => present,
    content => template('zserver/zagentd.conf.erb'),
    require => Package['zabbix-agent'],
    notify  => Service['zabbix-agent'],
  }

  service { 'zabbix-agent':
    ensure  => running,
    enable  => true,
    require => File['/etc/zabbix/zabbix_agentd.conf'],
  }

}
