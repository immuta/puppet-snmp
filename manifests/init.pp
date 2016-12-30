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
  anchor { 'snmp::end': }

}
