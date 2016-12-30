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
    enable          => $::snmp::snmpd_service_enable,
    ensure          => $::snmp::snmpd_service_ensure,
    hasstatus       => true,
    hasrestart      => true,
    require         => Package[$::snmp::snmpd_package_name],
  }
}
