class profile::logstash (

  ) {
  # -- check if we've designed for this OS:
  if $osfamily != 'RedHat' {
    fail("Logstash profile only designed so far for RedHat machines")
  } elsif ($operatingsystemrelease !~ /^7\.$/) {
    warning("Logstash profile only tested with CentOS 7")
  }

  class { '::elasticsearch':
    manage_repo  => true,
    repo_version => '1.4',
  } ->
  class { '::logstash':
    manage_repo  => true,
    repo_version => '1.4',
  }

  elasticsearch::instance { 'es-01': }

  logstash::configfile { 'syslog':
    source => 'puppet:///modules/profile/logstash/logstash-syslog.conf'
}


}
