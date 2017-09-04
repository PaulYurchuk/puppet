class zabbix_server::repo(

  $urlrepo='',
  $keyrepo='',
){

  yumrepo { 'zabbix':
    baseurl  => $urlrepo,
    descr    => 'Official Zabbix repository',
    gpgkey   => $keyrepo,
    enabled  => 1,
    gpgcheck => 1
  }
 
}
