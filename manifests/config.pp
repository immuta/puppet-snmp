# SNMP config class to configure snmpd, snmptrapd, snmp utilities
class snmp::config {
  file { $::snmp::snmpd_config_file:
    ensure  => 'present',
    mode    => '0644',
    owner   => 'root',
    group   => 'root',
    content => template('snmp/RedHat/snmpd/snmpd.conf.erb'),
    notify  => Service[$::snmp::snmpd_service_name]
  }

  file { '/etc/snmp/snmpd.conf.d':
    ensure => 'directory',
    owner  => 'root',
    group  => 'root',
    mode   => '0755',
  }

  file { '/etc/snmp/current_users':
    ensure => 'directory',
    owner  => 'root',
    group  => 'root',
    mode   => '0700',
  }
}
