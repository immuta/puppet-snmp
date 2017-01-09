# SNMP Class to install, configure snmpd, snmptrapd, snmp utilities
class snmp (

  $snmpd_package_ensure             = $::snmp::params::snmpd_package_ensure,
  $snmpd_package_name               = $::snmp::params::snmpd_package_name,

  $snmp_package_ensure              = $::snmp::params::snmp_package_ensure,
  $snmp_package_name                = $::snmp::params::snmp_package_name,

  $snmpd_service_ensure             = $::snmp::params::snmpd_service_ensure,
  $snmpd_service_enable             = $::snmp::params::snmpd_service_enable,
  $snmpd_service_name               = $::snmp::params::snmpd_service_name,

  $snmpd_config_file                = $::snmp::params::snmpd_config_file,

  $snmpd_config_agentaddress        = $::snmp::params::snmpd_config_agentaddress,
  $snmpd_config_sys_location        = $::snmp::params::snmpd_config_sys_location,
  $snmpd_config_sys_contact         = $::snmp::params::snmpd_config_sys_contact,
  $snmpd_config_sys_services        = $::snmp::params::snmpd_config_sys_services,
  $snmpd_config_sys_name            = $::snmp::params::snmpd_config_sys_name,

) inherits ::snmp::params {

  anchor { 'snmp::begin': } ->
  class { '::snmp::install': } ->
  class { '::snmp::config': } ->
  class { '::snmp::service': } ->
  anchor { 'snmp::end': }

  validate_string($snmpd_package_ensure)
  validate_string($snmp_package_ensure)
  validate_string($snmpd_service_ensure)
  validate_string($snmpd_package_name)
  validate_string($snmp_package_name)
  validate_string($snmpd_service_name)
  validate_string($snmpd_service_enable)
  validate_string($snmpd_config_file)
  validate_array($snmpd_config_agentaddress)

}
