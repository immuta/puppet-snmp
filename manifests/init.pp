class snmp (

  $snmpd_package_ensure             = $snmp::params::snmpd_package_ensure,
  $snmpd_package_name               = $snmp::params::snmpd_package_name,
  $snmpd_package_latest             = $snmp::params::snmpd_package_latest,
  $snmpd_service_name               = $snmp::params::snmpd_service_name,

  $snmp_package_ensure              = $snmp::params::snmp_package_ensure,
  $snmp_package_name                = $snmp::params::snmp_package_name,
  $snmp_package_latest              = $snmp::params::snmp_package_latest,

) inherits snmp::params {
  ##########################
  #
  # paramater validation
  #
  ##########################

  # validate input for snmpd
  if ! ($snmpd_package_ensure in ['present', 'absent']) {
    fail('snmpd_package_ensure parameter must be either present, or absent')
  }

  if ! ($snmpd_package_latestin [ true, false ]) {
    fail('snmpd_package_latest parameter must be either true or false')
  } 

  # validate input for snmp
  if ! ($snmp_package_ensure in ['present', 'absent']) {
    fail('snmp_package_ensure parameter must be either present, or absent')
  }

  if ! ($snmp_package_latestin [ true, false ]) {
    fail('snmp_package_latest parameter must be either true or false')
  }

  ##########################
  #
  # local variable settings
  #
  ##########################

  # set snmpd variables
  if $snmpd_package_ensure == 'present' {
    $snmpd_service_enable = true
    $snmpd_service_ensure = 'running'

    if $snmpd_package_latest {
      $snmpd_package_ensure = 'latest'
    } else {
      $snmpd_package_ensure = 'present'
    }
  } else {
    $snmpd_service_enable = false
    $snmpd_service_ensure = 'stopped'
    $snmpd_package_ensure = 'absent'
  }

  # set snmp variables
  # we do not have a snmp client service
  # this is simply the package for snmp client
  if $snmp_package_ensure == 'present' {
    if $snmp_package_latest {
      $snmp_package_ensure = 'latest'
    } else {
      $snmp_package_ensure = 'present'
    }
  } else {
    $snmp_package_ensure = 'absent'
  }

  ##########################
  #
  # package management
  #
  ##########################

  # snmpd package management
  package { $snmpd_package_name:
    ensure => $snmpd_package_ensure,
  }  
  
  package { $snmp_package_name:
    ensure => $snmp_package_name,
  }

  ##########################
  #
  # services management
  #
  ##########################
  
  # snmpd service
  service { $snmpd_service_name:
    enable          => $snmpd_service_enable,
    ensure          => $snmpd_service_ensure,
    hasstatus       => true,
    hasrestart      => true,  
  }







}
