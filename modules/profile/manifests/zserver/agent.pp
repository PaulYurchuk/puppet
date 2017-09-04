class profile::zserver::agent {

  $ip_servagent = lookup('profile::zserver::agent::ip_servagent')
  $urlrepo = lookup('profile::zserver::agent::urlrepo')
  $keyrepo = lookup('profile::zserver::agent::keyrepo')

  class { 'zabbix_server::agent':

  ip_servagent => $ip_servagent,
  }

  class { 'zabbix_server::repo':

  urlrepo => $urlrepo,
  keyrepo => $keyrepo,
  }
}
