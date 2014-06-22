class profile::gitlab {
  package { 'openssh-server':
    ensure => installed,
  }
  package { 'postfix':
    ensure => installed,
  }
  package { 'gitlab':
    require => [ Package['openssh-server'], Package['postfix'], ],
    source => 'https://downloads-packages.s3.amazonaws.com/centos-6.5/gitlab-6.9.2_omnibus.2-1.el6.x86_64.rpm',
    provider => rpm,
  }
  # FIXME not sure whether this runs EVERY time;
  # it should only run when package is installed.
  exec { '/usr/bin/gitlab-ctl reconfigure':
    subscribe => Package['gitlab'],
  }
  exec { '/usr/sbin/lokkit -s http -s ssh':
    subscribe => Package['gitlab'],
  }
}
