class role::zabbix_master {

  include profile::web::web
  include profile::database::customdb
  include profile::zserver::server
}
