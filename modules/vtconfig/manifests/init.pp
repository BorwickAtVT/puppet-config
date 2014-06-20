class vtconfig {
  file { '/etc/ssl/vt.pem':
    source => 'puppet:///files/vtconfig/vt.pem',
  }
}
