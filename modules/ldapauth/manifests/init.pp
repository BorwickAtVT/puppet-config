class ldapauth {
  if $operatingsystem == 'FreeBSD' {
    package { 'pam_ldap':
      ensure => installed,
    }

    package { 'openldap-client':
      ensure => installed,
    }

    file { '/usr/local/etc/ldap.conf':
      source => 'puppet:///modules/ldapauth/ldap.conf',
    }

    file { '/etc/pam.d/system':
      source => 'puppet:///modules/ldapauth/pam.d/system',
      mode => 0444,
      owner => 'root',
      group => 'wheel',
    }

    file { '/etc/pam.d/sshd':
      source => 'puppet:///modules/ldapauth/pam.d/sshd',
      mode => 0444,
      owner => 'root',
      group => 'wheel',
    }
  }
}
