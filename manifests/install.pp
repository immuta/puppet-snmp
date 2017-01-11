# SNMP Install class to install snmpd, snmptrapd, snmp utilities
class snmp::install {
  ##########################
  #
  # paramater validation
  #
  ##########################

  ##########################
  #
  # package management
  #
  ##########################

  # snmpd package management
  package { $::snmp::snmpd_package_name:
    ensure => $::snmp::snmpd_package_ensure,
    notify => Service[$::snmp::snmpd_service_name],
  }

  package { $::snmp::snmp_package_name:
    ensure => $::snmp::snmp_package_ensure,
  }
}
