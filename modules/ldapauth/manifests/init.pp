class ldapauth {
    case $operatingsystem {
         FreeBSD: {
            $ldap_conf = '/usr/local/etc/ldap.conf'
            $openldap_client = 'openldap-client'
         }
         CentOS: {
            $ldap_conf = '/etc/openldap/ldap.conf'
            $openldap_client = 'openldap-clients'
         }
    }
    # TODO make this error if the OS isn't listed

    # --- Packages needed:
    package { $openldap_client:
      ensure => installed,
    }

    if $operatingsystem == 'FreeBSD' {
        package { 'pam_ldap':
          ensure => installed,
        }
    } elsif $operatingsystem == 'CentOS' {
        package { 'nss-pam-ldapd':
          ensure => installed,
        }
    }

    # --- Files needed:
    file { $ldap_conf:
      source => 'puppet:///modules/ldapauth/ldap.conf',
      owner => 'root',
    }

    if $operatingsystem == 'FreeBSD' {
        file { '/etc/pam.d/system':
          source => 'puppet:///modules/ldapauth/freebsd/pam.d/system',
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
    } elsif $operatingsystem == 'CentOS' {
        file { '/etc/ldap.conf':
            ensure => 'link',
            target => $ldap_conf,
        }
        
    }
}
