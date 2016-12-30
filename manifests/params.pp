# SNMP Class to set default options
class snmp::params {
    $snmpd_package_ensure             = 'present'
    $snmpd_package_name               = 'net-snmp'

    $snmp_package_ensure              = 'absent'
    $snmp_package_name                = 'net-snmp-utils'

    $snmpd_service_ensure             = 'running'
    $snmpd_service_enable             = 'true'
    $snmpd_service_name               = 'snmpd'
}
