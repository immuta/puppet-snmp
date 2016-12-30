# SNMP Class to configure/enable snmpd, snmptrapd services
class snmp::service {
  ##########################
  #
  # Validate input
  #
  ##########################
  # validate input for snmpd service
  if ! ($::snmp::snmpd_service_ensure in ['running', 'stopped']) {
    fail('snmpd_package_ensure parameter must be either running, or stopped')
  }

  ##########################
  #
  # services management
  #
  ##########################

  # snmpd service
  service { $::snmp::snmpd_service_name:
    ensure     => $::snmp::snmpd_service_ensure,
    enable     => $::snmp::snmpd_service_enable,
    hasstatus  => true,
    hasrestart => true,
    require    => Package[$::snmp::snmpd_package_name],
  }
}
