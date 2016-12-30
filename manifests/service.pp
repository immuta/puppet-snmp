class snmp::service (
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
