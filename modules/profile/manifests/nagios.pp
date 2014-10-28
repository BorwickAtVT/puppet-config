class profile::nagios {
  if $osfamily != 'RedHat' {
    fail("Nagios profile only designed so far for RedHat machines")
  }
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
    notify => Service['nagios']
  }

  # PagerDuty:
  # (obviously designing for CentOS here)
  file { '/etc/yum.repos.d/pdagent.repo':
    source => 'puppet:///modules/profile/pagerduty/pdagent.repo',
  }

  $pagerduty_modules = [ 'pdagent', 'pdagent-integrations' ]
  package { $pagerduty_modules:
    require => File['/etc/yum.repos.d/pdagent.repo'],
  }

}
