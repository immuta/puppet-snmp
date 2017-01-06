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

    }
    'authNoPriv': {
      if ! ($auth_hash_type in ['MD5', 'SHA']) {
        fail('auth_hash_type parameter must be either MD5, or SHA')
      }
    }
    'authPriv': {
      if ! ($auth_hash_type in ['MD5', 'SHA']) {
        fail('auth_hash_type parameter must be either MD5, or SHA')
      }

      if ! ($priv_enc_type in ['AES', 'DES']) {
        fail('priv_enc_type parameter must be either AES, or DES')
      }
    }
    default: {
      fail('security_level paramater must be either noAuthNoPriv, authNoPriv, or authPriv')
    }
  }

  exec { "user_${user_name}":
    path    => '/bin:/sbin:/usr/bin:/usr/sbin',
    # TODO: Add "rwuser ${title}" (or rouser) to /etc/snmp/${daemon}.conf
    # command => "service ${service_name} stop ; sleep 5 ; echo \"${cmd}\" >>${snmp::params::var_net_snmp}/${daemon}.conf && touch ${snmp::params::var_net_snmp}/${title}-${daemon}",
    command => "echo \"${security_level}\" >> /tmp/security_level",
    # creates => "${snmp::params::var_net_snmp}/${title}-${daemon}",
    user    => 'root',
    #require => [ Package['snmpd'], File['var-net-snmp'], ],
    #before  => $service_before,
  }

  file_line { 'tmp_file':
    path    => '/tmp/snmpd.conf',
    line    => "${user_type} ${user_name} ${security_level}",
    match   => "^(ro|rw)user\s*((usm|tsm|ksm)\s*)*${user_name}.*\$",
    replace => true,
  }

}
