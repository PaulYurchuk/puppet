class role::zabbix::server {
  include profile::db
  include profile::web
  include profile::zabbix::server
}