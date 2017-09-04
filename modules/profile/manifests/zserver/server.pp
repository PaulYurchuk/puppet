class profile::zserver::server {

  $urlrepo = lookup('profile::zserver::server::urlrepo')
  $keyrepo = lookup('profile::zserver::server::keyrepo')
  $userdb = lookup('profile::zserver::server::userdb')
  $passdb = lookup('profile::zserver::server::passdb')
  $namedb = lookup('profile::zserver::server::namedb')
  $filldb = lookup('profile::zserver::server::filldb')
  $ip_servagent = lookup('profile::zserver::server::ip_servagent')

  class { 'zabbix_server':
    urlrepo      => $urlrepo,
    keyrepo      => $keyrepo,
    userdb       => $userdb,
    passdb       => $passdb,
    namedb       => $namedb,
    filldb       => $filldb,
    ip_servagent => $ip_servagent,
  }
}
