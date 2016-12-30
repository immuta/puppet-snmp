class snmp (

  $snmpd_package_ensure             = $snmp::params::snmpd_package_ensure,
  $snmpd_package_name               = $snmp::params::snmpd_package_name,
  $snmpd_package_latest             = $snmp::params::snmpd_package_latest,
  $snmpd_service_name               = $snmp::params::snmpd_service_name,

  $snmp_package_ensure              = $snmp::params::snmp_package_ensure,
  $snmp_package_name                = $snmp::params::snmp_package_name,
  $snmp_package_latest              = $snmp::params::snmp_package_latest,

) inherits snmp::params {
  
  anchor { 'snmp::begin': } ->
  class { '::snmp::install': } ->
  class { '::snmp::service': } ->
  anchor { 'snmp::end': }

  validate_boolean($snmpd_package_ensure)
  validate_string($snmpd_package_name)
  validate_string($snmpd_package_latest)
  validate_string($snmpd_service_name)
  validate_boolean($snmp_package_ensure)
  validate_string($snmp_package_name)
  validate_string($snmp_package_latest)

}
