package { 'pam_ldap':
  ensure => installed,
}

package { 'openldap-client':
  ensure => installed,
}

file { '/usr/local/etc/ldap.conf':
  source => 'puppet:///files/ldap_auth/ldap.conf',
}

file { '/etc/pam.d/sshd':
  source => 'puppet:///files/ldap_auth/pam.d/sshd',
}
