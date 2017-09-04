class profile::web {
  package { 'httpd':
  ensure  => 'installed',
  }
}