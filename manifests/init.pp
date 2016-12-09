class snmp (

  $snmpd_package_ensure             = $snmp::params::snmpd::package_ensure,
  $snmpd_package_name               = $snmp::params::snmpd::package_name,

) inherits snmp::params {
  
  class{'snmp::install::snmpd': } ->
  Class["snmp"]
}
