This is a not-production example of a git repository used by a puppet master.

To use
---

For development at least, this project is intended to be used
alongside the [puppetenv](https://github.com/BorwickAtVT/puppetenv)
project. Basically, the puppetenv project sets up a Vagrant
environment for experimentation. Here's how to set it up:

1. Go ahead and run `make` in this directory. This will do server-side
   things like downloading certificates.

2. Configure `manifests/site.pp`, for example by copying it from
   `site.pp.example`.

2. Checkout `puppetenv`

3. Check out this repository into a sub-directory of `puppetenv`
   called `puppet-config`

4. When you run Vagrant within puppetenv, it will mount
   `puppet-config` (this project) on a virtual machine called `alpha`.
   This project will be the puppet config for `alpha`.

The philosophy is that `puppetenv` will get the environment ready,
including the puppet master and clients, so that you can develop the
actual puppet configs in this (separate) project. To mess around,
populate `manifests/site.pp` to whatever you want it to be.


TOOLS NEEDED
---

* `librarian-puppet`

How to add standard modules
---

If you identify that you need to install a standard module,

1. Add it to `Puppetfile`

2. See whether `librarian-puppet install` installs it

3. If it does, add the module directory to `modules/.gitignore`
