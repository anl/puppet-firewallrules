# == Class: firewallrules::post
#
# Global default late rules for PuppetLabs firewall module.
#
# See https://github.com/puppetlabs/puppetlabs-firewall#readme.
#
# === Parameters
#
# (None)
#
# === Examples
#
#
#
# === Authors
#
# Andrew Leonard
#
# === Copyright
#
# Copyright 2013 Andrew Leonard
#
class firewallrules::post {
  firewall { '999 drop all':
    proto   => 'all',
    action  => 'drop',
    before  => undef,
  }

  unless $::ipaddress6 == undef {
    firewall { '999 drop v6 all':
      proto    => 'all',
      action   => 'drop',
      before   => undef,
      provider => 'ip6tables'
    }
  }
}
