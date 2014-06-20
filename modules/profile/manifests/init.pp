class profile::base {
  package { 'bash':
    ensure => installed,
  }

  include vtconfig
  include ldapauth
}
