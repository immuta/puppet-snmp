class snmp::params {
    $snmpd_package_ensure             = 'present'
    $snmpd_package_name               = 'net-snmp'
    $snmpd_package_latest             = false,
    $snmpd_service_name               = 'snmpd'

    $snmp_package_ensure              = 'absent'
    $snmp_package_latest              = false,
    $snmp_package_name                = 'net-snmp-utils'
}
