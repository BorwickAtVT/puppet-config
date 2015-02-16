class role {
  include profile::base
}

class role::placeholder inherits role {

}


# Role for the manager
class role::brain inherits role {
  include profile::nagios
#  include profile::logstash
}

