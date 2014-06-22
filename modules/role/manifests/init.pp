class role {
  include profile::base
}

class role::placeholder inherits role {

}


class role::vc_repo inherits role {
  include profile::gitlab
}
