# SNMP class to configure and add V3 user for snmpd, snmptrapd utilities
define snmp::user (
  $daemon_type    = 'snmpd',
  $user_name      = undef,
  $user_type      = 'rouser',
  $security_level = undef,
  $auth_hash_type = 'SHA',
  $auth_password  = undef,
  $priv_enc_type  = 'AES',
  $priv_password  = undef,
) {

  validate_string($user_name)

  if ! ($daemon_type in ['snmpd', 'snmptrapd']) {
    fail('daemon_type parameter must be either snmpd, or snmptrapd')
  }

  if ! ($user_type in ['rouser', 'rwuser']) {
    fail('user_Type paramater must be either rouser, or rwuser')
  }

  case $security_level {
    'noAuthNoPriv': {
      $createUser = "createUser ${user_name}"
    }
    'authNoPriv': {
      if ! ($auth_hash_type in ['MD5', 'SHA']) {
        fail('auth_hash_type parameter must be either MD5, or SHA')
      }

      $createUser = "createUser ${user_name} ${auth_hash_type} \\\"${auth_password}\\\""
    }
    'authPriv': {
      if ! ($auth_hash_type in ['MD5', 'SHA']) {
        fail('auth_hash_type parameter must be either MD5, or SHA')
      }

      if ! ($priv_enc_type in ['AES', 'DES']) {
        fail('priv_enc_type parameter must be either AES, or DES')
      }
      $createUser = "createUser ${user_name} ${auth_hash_type} \\\"${auth_password}\\\" ${priv_enc_type} \\\"${priv_password}\\\""
    }
    default: {
      fail('security_level paramater must be either noAuthNoPriv, authNoPriv, or authPriv')
    }
  }

  exec { 'stop_snmpd':
    path    => '/bin:/sbin:/usr/bin:/usr/sbin',
    command => "service snmpd stop; sleep 5",
    user    => 'root',
  }

  file_line { $::snmp::snmpd_config_file:
    path    => '/etc/snmp/snmpd.conf',
    line    => "${user_type} ${user_name} ${security_level}",
    match   => "^(ro|rw)user\s*((usm|tsm|ksm)\s*)*${user_name}.*\$",
    replace => true,
    before  => exec['start_snmpd'],
    require => exec['stop_snmpd'],
  }

  file_line { 'usm_snmpd_file':
    path    => '/var/lib/net-snmp/snmpd.conf',
    line    => $createUser,
    before  => exec['start_snmpd'],
    require => exec['stop_snmpd'],
  }

  exec { 'start_snmpd':
    path    => '/bin:/sbin:/usr/bin:/usr/sbin',
    command => "service snmpd start",
    user    => 'root',
    require => exec['stop_snmpd'],
  }
}
