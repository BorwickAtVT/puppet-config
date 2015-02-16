class profile::nagios (

  ) {
  # -- check if we've designed for this OS:
  if $osfamily != 'RedHat' {
    fail("Nagios profile only designed so far for RedHat machines")
  } elsif ($operatingsystemrelease !~ /^7\.$/) {
    warning("Nagios profile only tested with CentOS 7")
  }


  # -- nagios will also be a web server:
  package { 'httpd':
    ensure => installed,
  }

  service { 'httpd':
    ensure => running,
    require => Package['httpd'],
  }

  # -- install nagios RPM:
  package { 'nagios':
    ensure => installed,
    require => Package['httpd'],
    notify => Service['httpd'],     # restart httpd after conf.d change
  }

  # -- check out nagios config:
  package { 'git':
    ensure => installed,
  }

  if $etc_nagios_git == true {
    $vcs_force = false
  } else {
    $vcs_force = true
  }

  # check out. TODO does this pull updates ?
  vcsrepo { "/etc/nagios/":
    ensure   => present,
    provider => git,
    source   => hiera('nagios_repo'),
    require => Package['git'],
    notify => Service['nagios'],
    force => $vcs_force,
  }

  # TODO populate /etc/nagios/private etc
  # use hiera-eyaml ?
  
  # -- add PagerDuty support:
  file { '/etc/yum.repos.d/pdagent.repo':
    source => 'puppet:///modules/profile/pagerduty/pdagent.repo',
  }

  $pagerduty_modules = [ 'pdagent', 'pdagent-integrations' ]
  package { $pagerduty_modules:
    require => File['/etc/yum.repos.d/pdagent.repo'],
  }

  # -- start Nagios:
  service { 'nagios':
    enable => true,
    ensure => running,
    require => Vcsrepo['/etc/nagios/'],
  }

}
