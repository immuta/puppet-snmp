class snmp::install {
  class snmp::install::snmpd {
    package { $snmpd_package_name:
      ensure => $snmpd_package_ensure,
      name   => $snmpd_package_name,
    }
  }
}
