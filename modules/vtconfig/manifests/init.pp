class vtconfig {
  file { '/etc/ssl/vt.pem':
    source => 'puppet:///modules/vtconfig/vt.pem',
  }
}
