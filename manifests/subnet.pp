define dhcp::subnet (
    $network,
    $mask,
    $pools,
    $gateway,
    $dnsdomain=undef,
    $nameservers=undef,
    $options=[]
  ) {

    include dhcp::params

    $dhcp_dir = $dhcp::params::dhcp_dir

    $netnameservers = $nameservers ? {
      undef   => $dhcp::nameservers,
      default => $nameservers
    }

    $netdomain = $dnsdomain ? {
      undef   => $dhcp::dnsdomain,
      default => $dnsdomain
    }

    concat::fragment {
        "dhcp_pool_${name}":
            target  => "${dhcp_dir}/dhcpd.pools",
            content => template("dhcp/dhcpd.subnet.erb");
    }
}

