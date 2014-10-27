class profile::base {
  if $operatingsystem == 'FreeBSD' {
    Package {
      provider => pkgng,
    }
  }

  package { 'bash':
    ensure => installed,
  }

  include vtconfig
  include ldapauth
}
