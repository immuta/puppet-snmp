# SNMP Class to install, configure snmpd, snmptrapd, snmp utilities
class snmp (

  $snmpd_package_ensure             = $snmp::params::snmpd_package_ensure,
  $snmpd_package_name               = $snmp::params::snmpd_package_name,

  $snmp_package_ensure              = $snmp::params::snmp_package_ensure,
  $snmp_package_name                = $snmp::params::snmp_package_name,

  $snmpd_service_ensure             = $snmp::params::snmpd_service_ensure,
  $snmpd_service_name               = $snmp::params::snmpd_service_name,

) inherits ::snmp::params {

  anchor { 'snmp::begin': } ->
  class { '::snmp::install': } ->
  class { '::snmp::service': } ->
  anchor { 'snmp::end': }

  validate_string($snmpd_package_ensure)
  validate_string($snmp_package_ensure)
  validate_string($snmpd_service_ensure)
  validate_string($snmpd_package_name)
  validate_string($snmp_package_name)
  validate_string($snmpd_service_name)

}
