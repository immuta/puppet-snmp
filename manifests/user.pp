# SNMP class to configure and add V3 user for snmpd, snmptrapd utilities
define snmp::user (
  $daemon_type        = 'snmpd',
  $user_name          = $title,
  $user_type          = 'rouser',
  $security_level     = undef,
  $auth_hash_type     = 'SHA',
  $auth_password      = undef,
  $priv_enc_type      = 'AES',
  $priv_password      = undef,
  $snmpd_service_name = $::snmp::snmpd_service_name,
) {
  Class['snmp::config'] -> Snmp::User[$title]

  validate_string($user_name)

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
    ensure  => 'present',
    mode    => '0644',
    owner   => 'root',
    group   => 'root',
    content => template("snmp/${::osfamily}/snmpd/snmpd.conf.d/users.conf.erb"),
    before  => File["${user_name}_flag"],
  }

  file { "${user_name}_flag":
    ensure  => 'file',
    path    => "/etc/snmp/current_users/${user_name}",
    mode    => '0700',
    owner   => 'root',
    group   => 'root',
    content => fqdn_rand_string(64, '', "${auth_password}${priv_password}"),
    notify  => Exec["add_user_${user_name}"],
  }

  exec { "add_user_${user_name}":
    path        => '/bin:/sbin:/usr/bin:/usr/sbin',
    command     => "service ${snmpd_service_name} stop ; sleep 5 ; echo \"${createuser}\" >> /var/lib/net-snmp/snmpd.conf ; service ${snmpd_service_name} start",
    user        => 'root',
    refreshonly => true,
  }
}
