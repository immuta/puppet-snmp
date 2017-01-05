# SNMP Install class to install snmpd, snmptrapd, snmp utilities
class snmp::install {
  ##########################
  #
  # paramater validation
  #
  ##########################

  # validate input for snmpd
  if ! ($::snmp::snmpd_package_ensure in ['present', 'absent', 'latest']) {
    fail('snmpd_package_ensure parameter must be either present, absent, or latest')
  }

  # validate input for snmp
  if ! ($::snmp::snmp_package_ensure in ['present', 'absent', 'latest']) {
    fail('snmp_package_ensure parameter must be either present, absent, or latest')
  }

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
