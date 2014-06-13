if $operatingsystem == 'FreeBSD' {
  Package {
    provider => pkgng,
  }
}

package { 'bash':
  ensure => installed,
}

file { '/etc/ssl/vt.pem':
  source => 'puppet:///files/ssl/vt.pem',
}

import 'ldap_auth.pp'
