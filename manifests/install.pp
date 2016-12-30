class snmp::install {
  ##########################
  #
  # paramater validation
  #
  ##########################

  # validate input for snmpd
  if ! ($::snmp::snmpd_package_ensure in ['present', 'absent']) {
    fail('snmpd_package_ensure parameter must be either present, or absent')
  }

  if ! ($::snmp::snmpd_package_latest in [ true, false ]) {
    fail('snmpd_package_latest parameter must be either true or false')
  } 

  # validate input for snmp
  if ! ($::snmp::snmp_package_ensure in ['present', 'absent']) {
    fail('snmp_package_ensure parameter must be either present, or absent')
  }

  if ! ($::snmp::snmp_package_latest in [ true, false ]) {
    fail('snmp_package_latest parameter must be either true or false')
  }

  ##########################
  #
  # local variable settings
  #
  ##########################

  # set snmpd variables
  if $::snmp::snmpd_package_ensure == 'present' {
    $::snmp::snmpd_service_enable = true
    $::snmp::snmpd_service_ensure = 'running'

    if $::snmp::snmpd_package_latest {
      $::snmp::snmpd_package_ensure = 'latest'
    } else {
      $::snmp::snmpd_package_ensure = 'present'
    }
  } else {
    $::snmp::snmpd_service_enable = false
    $::snmp::snmpd_service_ensure = 'stopped'
    $::snmp::snmpd_package_ensure = 'absent'
  }

  # set snmp variables
  # we do not have a snmp client service
  # this is simply the package for snmp client
  if $::snmp::snmp_package_ensure == 'present' {
    if $::snmp::snmp_package_latest {
      $::snmp::snmp_package_ensure = 'latest'
    } else {
      $::snmp::snmp_package_ensure = 'present'
    }
  } else {
    $::snmp::snmp_package_ensure = 'absent'
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
    ensure => $::snmp::snmp_package_name,
  }
}
