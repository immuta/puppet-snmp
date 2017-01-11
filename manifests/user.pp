# SNMP class to configure and add V3 user for snmpd, snmptrapd utilities
define snmp::user (
  $daemon_type    = 'snmpd',
  $user_name      = $title,
  $user_type      = 'rouser',
  $security_level = undef,
  $auth_hash_type = 'SHA',
  $auth_password  = undef,
  $priv_enc_type  = 'AES',
  $priv_password  = undef,
  $snmpd_service_name = $::snmp::snmpd_service_name,

  $oid_auth           = $::snmp::oid_auth,
  $oid_priv           = $::snmp::oid_priv,
) {
  validate_string($user_name)

  notice( "${auth_hash_type}: ${oid_auth['${auth_hash_type}']}" )
  notice( "${priv_enc_type}: ${oid_priv['${priv_enc_type}']}" )

  if ! ($daemon_type in ['snmpd', 'snmptrapd']) {
    fail('daemon_type parameter must be either snmpd, or snmptrapd')
  }

  if ! ($user_type in ['rouser', 'rwuser']) {
    fail('user_Type paramater must be either rouser, or rwuser')
  }

  case $security_level {
    'noAuthNoPriv': {
      $createuser = "createUser ${user_name}"
    }
    'authNoPriv': {
      if ! ($auth_hash_type in ['MD5', 'SHA']) {
        fail('auth_hash_type parameter must be either MD5, or SHA')
      }

      $createuser = "createUser ${user_name} ${auth_hash_type} \"${auth_password}\""
    }
    'authPriv': {
      if ! ($auth_hash_type in ['MD5', 'SHA']) {
        fail('auth_hash_type parameter must be either MD5, or SHA')
      }

      if ! ($priv_enc_type in ['AES', 'DES']) {
        fail('priv_enc_type parameter must be either AES, or DES')
      }
      $createuser = "createUser ${user_name} ${auth_hash_type} \"${auth_password}\" ${priv_enc_type} \"${priv_password}\""
    }
    default: {
      fail('security_level paramater must be either noAuthNoPriv, authNoPriv, or authPriv')
    }
  }

  file { "/etc/snmp/snmpd.conf.d/user_${user_name}.conf":
    ensure  => present,
    mode    => '0644',
    owner   => 'root',
    group   => 'root',
    content => template('snmp/RedHat/snmpd/snmpd.conf.d/users.conf.erb'),
    before  => Exec['stop_snmpd'],
  }

  exec { 'stop_snmpd':
    path    => '/bin:/sbin:/usr/bin:/usr/sbin',
    command => "service ${snmpd_service_name} stop; sleep 5",
    user    => 'root',
  }

  file_line { "usm_${user_name}":
    path    => '/var/lib/net-snmp/snmpd.conf',
    line    => $createuser,
    before  => Exec['start_snmpd'],
    require => Exec['stop_snmpd'],
  }

  exec { 'start_snmpd':
    path    => '/bin:/sbin:/usr/bin:/usr/sbin',
    command => "service ${snmpd_service_name} start",
    user    => 'root',
    require => Exec['stop_snmpd'],
  }
}
