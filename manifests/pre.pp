# == Class: firewallrules::pre
#
# Global default early rules for PuppetLabs firewall module.
#
# See https://github.com/puppetlabs/puppetlabs-firewall#readme
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
# Andrew Leonard, based heavily on puppetlabs/firewall docs (Apache 2.0)
#
# === Copyright
#
# Copyright 2013 Andrew Leonard
#
class firewallrules::pre {

  # Unset the default "require" parameter pointing to this class; see
  # https://github.com/puppetlabs/puppetlabs-firewall#readme
  Firewall {
    require => undef,
  }

  # Default IPv4 firewall rules
  firewall { '000 accept all icmp':
    proto   => 'icmp',
    action  => 'accept',
  }->

  firewall { '001 accept all to lo interface':
    proto   => 'all',
    iniface => 'lo',
    action  => 'accept',
  }->

  firewall { '002 accept related established rules':
    proto   => 'all',
    state   => ['RELATED', 'ESTABLISHED'],
    action  => 'accept',
  }

  firewall { '003 accept outbound traffic':
    action => 'accept',
    chain  => 'OUTPUT',
    proto  => 'all',
    state  => [ 'ESTABLISHED', 'NEW', 'RELATED' ],
  }


  # Default IPv6 firewall rules
  unless $::ipaddress6 == undef {
    firewall { '000 accept all icmp6':
      proto    => 'icmp',
      action   => 'accept',
      provider => 'ip6tables',
    }->

    firewall { '001 accept all v6 to lo interface':
      proto    => 'all',
      iniface  => 'lo',
      action   => 'accept',
      provider => 'ip6tables',
    }->

    firewall { '002 accept v6 related established rules':
      proto    => 'all',
      state    => ['RELATED', 'ESTABLISHED'],
      action   => 'accept',
      provider => 'ip6tables',
    }

    firewall { '003 accept v6 outbound traffic':
      action   => 'accept',
      chain    => 'OUTPUT',
      proto    => 'all',
      state    => [ 'ESTABLISHED', 'NEW', 'RELATED' ],
      provider => 'ip6tables',
    }
  }
}
