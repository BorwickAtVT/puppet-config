class profile::nagios {
  package { 'nagios':
    ensure => installed,
  }

  service { 'nagios':
    enable => true,
    ensure => running,
    require => Package['nagios'],
  }
}
