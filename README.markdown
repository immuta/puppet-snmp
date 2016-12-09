#Net-SNMP

####Table of Contents

1. [Overview](#overview)
2. [Module Description - What the module does and why it is useful](#module-description)
3. [Setup - The basics of getting started with this module](#setup)
4. [Usage - Configuration options and additional functionality](#usage)
5. [Reference - An under-the-hood peek at what the module is doing and how](#reference)
6. [Limitations - OS compatibility, etc.](#limitations)

##Overview

This Puppet module manages the installation and configuration of [Net-SNMP](http://www.net-snmp.org/) client, server, and trap server.  It also can create a SNMPv3 user with authentication and privacy passwords.

##Module Description

SNMP, Simple Network Management Protocol, is a protocol for monitoring remote metrics across a number of devices. 

SNMPv1, SNMPv2, and SNMPv3 are the versions currently in existance.

SNMPv3 supports both authorization, and privacy.

Authorization uses either MD5, or SHA
Privacy, and thus encryption is done using either DES, or AES.
