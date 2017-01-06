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

  concat { $::snmp::snmpd_config_v3user:
    ensure         => 'present',
    owner          => 'root',
    group          => 'root',
    mode           => '0700',
    ensure_newline => true,
    content        => "${::snmp::snmpd_config_v3user}\n",
    notify         => Class['::snmp::service'],
  }

}
