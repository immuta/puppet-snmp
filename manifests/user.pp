# SNMP class to configure and add V3 user for snmpd, snmptrapd utilities
class snmp::user (
  $daemon_type    = 'snmpd',
  $user_name      = undef,
  $user_type      = 'readonly',
  $security_level = undef,
  $auth_hash_type = 'SHA',
  $auth_password  = undef,
  $priv_enc_type  = 'AES',
  $priv_password  = undef,
) {

  validate_string($user_name)

  if ! ($::snmp::user::daemon_type in ['snmpd', 'snmptrapd']) {
    fail('daemon_type parameter must be either snmpd, or snmptrapd')
  }

  if ! ($::snmp::user::user_type in ['readonly', 'readwrite']) {
    fail('user_Type paramater must be either readonly, or readwrite')
  }

  case $security_level {
    'noAuthNoPriv': {

    }
    'authNoPriv': {
      if ! ($::snmp::user::auth_hash_type in ['MD5', 'SHA']) {
        fail('auth_hash_type parameter must be either MD5, or SHA')
      }
    }
    'authPriv': {
      if ! ($::snmp::user::auth_hash_type in ['MD5', 'SHA']) {
        fail('auth_hash_type parameter must be either MD5, or SHA')
      }

      if ! ($::snmp::user::priv_enc_type in ['AES', 'DES']) {
        fail('priv_enc_type parameter must be either AES, or DES')
      }
    }
    default: {
      fail('security_level paramater must be either noAuthNoPriv, authNoPriv, or authPriv')
    }
  }

  if ! ($::snmp::user::auth_hash_type in ['MD5', 'SHA']) {
    fail('auth_hash_type parameter must be either MD5, or SHA')
  }

  if ! ($::snmp::user::priv_enc_type in ['AES', 'DES']) {
    fail('priv_enc_type parameter must be either AES, or DES')
  }

}
