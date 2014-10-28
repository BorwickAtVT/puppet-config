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
    source   => "https://github.com/leachim6/hello-world",
    require => Package['git'],
    force => true,
    notify => Service['nagios']
  }

}
