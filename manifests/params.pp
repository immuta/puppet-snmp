# SNMP Class to set default options
class snmp::params {
  $snmpd_package_ensure      = 'present'
  $snmpd_package_name        = 'net-snmp'

  $snmp_package_ensure       = 'present'
  $snmp_package_name         = 'net-snmp-utils'

  $snmpd_service_ensure      = 'running'
  $snmpd_service_enable      = 'true'
  $snmpd_service_name        = 'snmpd'

  $snmpd_config_file         = '/etc/snmp/snmpd.conf'

  $snmpd_config_agentaddress = [ 'udp:127.0.0.1:161' ]
  $snmpd_config_sys_location = 'Unknown'
  $snmpd_config_sys_contact  = 'Unknown'
  $snmpd_config_sys_services = 'Unknown'
  $snmpd_config_sys_name     = $::fqdn

  $oid_auth                  = { md5 => '.1.3.6.1.6.3.10.1.1.2', sha => '.1.3.6.1.6.3.10.1.1.3' }
  $oid_priv                  = { des => '.1.3.6.1.6.3.10.1.2.2', 3des => '.1.3.6.1.6.3.10.1.2.3', aes => '.1.3.6.1.6.3.10.1.2.4' }
}
