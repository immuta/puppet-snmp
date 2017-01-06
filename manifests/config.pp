# SNMP config class to configure snmpd, snmptrapd, snmp utilities
class snmp::config {

  file { $::snmp::snmpd_config_file:
    ensure  => present,
    mode    => '0644',
    owner   => 'root',
    group   => 'root',
    path    => $::snmp::snmpd_config_file,
    content => template('snmp/RedHat/snmpd/snmpd.conf.erb'),
  }

  file_line { 'snmp_v3user':
    path  => $::snmp::snmpd_config_v3user,
    line  => "createUser bob",
    match => "^createUser",
  }

}
