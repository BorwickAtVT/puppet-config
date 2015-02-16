class profile::base {
  # TODO I am sure there is a better way to do this.
  
  if $osfamily == 'FreeBSD' {
    Package {
      provider => pkgng,
    }
  }

  if $osfamily == 'RedHat' {
    include epel
  }

  package { 'bash':
    ensure => installed,
  }

  package { 'lsof':
    ensure => installed,
  }

  include vtconfig
  include ldapauth
}
