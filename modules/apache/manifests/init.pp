class apache {

  case $facts['osfamily'] {
   'RedHat', 'CentOS':  {
     $server = 'httpd'
     $vhost_path = '/etc/httpd/conf.d/vhost.conf'
     $sname = $facts['ipaddress_enp0s8']
    }

    /^(Debian|Ubuntu)$/:{ 
     $server = 'apache2'
     $vhost_path = '/etc/apache2/sites-enabled/vhost.conf'
     $sname = $facts['ipaddress_eth1']
    }

    default: { fail ('The system is unknown')}
  }

  package { $server:
    ensure => installed,
    before => File['/var/www/public/'],
  }
   
  file { '/var/www/public/':
    ensure    => directory,
    before => File['/var/www/public/index.html'],
  }
  
  file { '/var/www/public/index.html':
    ensure => file,
    content  => template('apache/index.html.erb'),
    before => File[$vhost_path],
  }

  $vhost_hash = {
    'sname' => $sname,
  }

  file { $vhost_path:
    content => epp('apache/vhost.conf.epp', $vhost_hash),
    notify => Service[$server],
  }

  service { $server:
    ensure => running,
    enable => true,
    require => Package[$server],
  }
}
