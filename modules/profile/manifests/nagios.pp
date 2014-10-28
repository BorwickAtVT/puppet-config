class profile::nagios {
  package { 'nagios':
    ensure => installed,
  }

  service { 'nagios':
    enable => true,
    ensure => running,
    require => Package['nagios'],
  }

  package { 'git':
    ensure => installed,
    }

  vcsrepo { "/etc/nagios/":
    ensure   => present,
    provider => git,
    source   => hiera('nagios_repo'),
    require => Package['git'],
    force => true,
    notify => Service['nagios']
  }

}
