# Class: collectd::setup::settings
#
# A list of default collectd plugins + a list of packages required to use
# some of these plugins.
#
# Scaffolding code, it shouldn't be needed to directly call it when using
# this module.
#
class collectd::setup::settings {

  # These are packages which are required for the plugins to work correctly.
  # They are declared in collect::package and realize()d on demand.
  # Debian users should read /usr/share/doc/collectd-core/README.Debian.plugins
  $plugindeps = {
    'Debian' => {
      'amqp'            => ['librabbitmq0'],
      'apache'          => ['libcurl3-gnutls'],
      'ascent'          => ['libcurl3-gnutls', 'libxml2'],
      'bind'            => ['libcurl3-gnutls', 'libxml2'],
      'curl'            => ['libcurl3-gnutls'],
      'curl_json'       => "${::operatingsystem}${::operatingsystemmajrelease}" ? {
        /Debian6/ => ['libcurl3-gnutls', 'libyajl1'],
        /Ubuntu12.04/ => ['libcurl3-gnutls', 'libyajl1'],
        default   => ['libcurl3-gnutls', 'libyajl2'],
      },
      'curl_xml'        => ['libcurl3-gnutls', 'libxml2'],
      'dbi'             => ['libdbi1'],
      'disk'            => ['libudev0'],
      'dns'             => ['libpcap0.8'],
      'ipmi'            => ['libopenipmi0'],
      'libvirt'         => ['libvirt0', 'libxml2'],
      'log_logstash'    => $::lsbdistcodename ? {
        /squeeze/ => ['libyajl1'],
        /precise/ => ['libyajl1'],
        default   => ['libyajl2'],
      },
      'lvm'             => ['liblvm2app2.2'],
      'memcachec'       => "${::operatingsystem}${::operatingsystemmajrelease}" ? {
        /Debian6/ => ['libmemcached5'],
        /Ubuntu12.04/ => ['libmemcached6'],
        default   => ['libmemcached10'],
      },
      'modbus'          => ['libmodbus5'],
      'mysql'           => "${::operatingsystem}${::operatingsystemmajrelease}" ? {
        /Debian6/ => ['libmysqlclient16'],
        default   => ['libmysqlclient18'],
      },
      'network'         => ['libgcrypt11'],
      'netlink'         => ['libmnl0'],
      'nginx'           => ['libcurl3-gnutls'],
      'notify_desktop'  => ['libgdk-pixbuf2.0-0', 'libglib2.0-0', 'libnotify4'],
      'notify_email'    => ['libesmtp6', 'libssl1.0.0'],
      'nut'             => ['libupsclient1'],
      'openldap'        => ['libldap-2.4-2'],
      'perl'            => "${::operatingsystem}${::operatingsystemmajrelease}" ? {
        /Debian6/ => ['libperl5.10'],
        default   => ['libperl5.14'],
      },
      'pinba'           => ['libprotobuf-c0'],
      'ping'            => ['liboping0'],
      'postgresql'      => ['libpq5'],
      'python'          => "${::operatingsystem}${::operatingsystemmajrelease}" ? {
        /Debian6/ => ['libpython2.6'],
        default   => ['libpython2.7'],
      },
      'rrdcached'       => ['librrd4'],
      'rrdtool'         => ['librrd4'],
      'sensors'         => ['lm-sensors', 'libsensors4'],
      'smart'           => ['libatasmart4'],
      'snmp'            => ['libsnmp15'],
      'tokyotyrant'     => ['libtokyotyrant3'],
      'uuid'            => ['libdbus-1-3', 'libhal1'],
      'varnish'         => ['libvarnishapi1'],
      'virt'            => ['libvirt0', 'libxml2'],
      'write_http'      => ['libcurl3-gnutls'],
      'write_kafka'     => ['librdkafka1'],
      'write_riemann'   => ['libprotobuf-c0'],
    },

    'RedHat' => {
      'amqp'            => ['collectd-amqp'],
      'apache'          => ['collectd-apache'],
      'ascent'          => ['collectd-ascent'],
      'bind'            => ['collectd-bind'],
      'curl'            => ['collectd-curl'],
      'curl_json'       => ['collectd-curl_json'],
      'curl_xml'        => ['collectd-curl_xml'],
      'dbi'             => ['collectd-dbi'],
      'disk'            => ['collectd-disk'],
      'dns'             => ['collectd-dns'],
      'email'           => ['collectd-email'],
      'gmond'           => ['collectd-gmond'],
      'hddtemp'         => ['collectd-hddtemp'],
      'ipmi'            => ['collectd-ipmi'],
      'iptables'        => ['collectd-iptables'],
      'java'            => ['collectd-java'],
      'libvirt'         => ['collectd-libvirt'],
      'log_logstash'    => ['collectd-log_logstash'],
      'lvm'             => ['collectd-lvm'],
      'memcachec'       => ['collectd-memcachec'],
      'modbus'          => ['collectd-modbus'],
      'mysql'           => ['collectd-mysql'],
      'netlink'         => ['collectd-netlink'],
      'nginx'           => ['collectd-nginx'],
      'notify_desktop'  => ['collectd-notify_desktop'],
      'notify_email'    => ['collectd-notify_email'],
      'nut'             => ['collectd-nut'],
      'openldap'        => ['collectd-openldap'],
      'perl'            => ['collectd-perl'],
      'pinba'           => ['collectd-pinba'],
      'ping'            => ['collectd-ping'],
      'postgresql'      => ['collectd-postgresql'],
      'python'          => ['collectd-python'],
      'rrdcached'       => ['collectd-rrdcached'],
      'rrdtool'         => ['collectd-rrdtool'],
      'sensors'         => ['collectd-sensors'],
      'smart'           => ['collectd-smart'],
      'snmp'            => ['collectd-snmp'],
      'varnish'         => ['collectd-varnish'],
      'virt'            => ['collectd-virt'],
      'write_http'      => ['collectd-write_http'],
      'write_riemann'   => ['collectd-write_riemann'],
    },
  }

  # Plugin list generated from collectd's source tree with:
  # egrep '@<?LoadPlugin' src/collectd.conf.in | \
  #   sed -r 's/.*@<?LoadPlugin\s+"?(\w+)"?>?/"\1",/' |sort
  $defaultplugins = [
    'aggregation',
    'amqp',
    'apache',
    'apcups',
    'apple_sensors',
    'aquaero',
    'ascent',
    'barometer',
    'battery',
    'bind',
    'cgroups',
    'conntrack',
    'contextswitch',
    'cpu',
    'cpufreq',
    'csv',
    'curl',
    'curl_json',
    'curl_xml',
    'dbi',
    'df',
    'disk',
    'dns',
    'drbd',
    'email',
    'entropy',
    'ethstat',
    'exec',
    'filecount',
    'fscache',
    'gmond',
    'hddtemp',
    'interface',
    'ipmi',
    'iptables',
    'ipvs',
    'irq',
    'java',
    'libvirt',
    'load',
    'logfile',
    'log_logstash',
    'lpar',
    'lvm',
    'madwifi',
    'match_empty_counter',
    'match_hashed',
    'match_regex',
    'match_timediff',
    'match_value',
    'mbmon',
    'md',
    'memcachec',
    'memcached',
    'memory',
    'mic',
    'modbus',
    'multimeter',
    'mysql',
    'netapp',
    'netlink',
    'network',
    'nfs',
    'nginx',
    'notify_desktop',
    'notify_email',
    'ntpd',
    'numa',
    'nut',
    'olsrd',
    'onewire',
    'openldap',
    'openvpn',
    'oracle',
    'perl',
    'pinba',
    'ping',
    'postgresql',
    'powerdns',
    'processes',
    'protocols',
    'python',
    'redis',
    'routeros',
    'rrdcached',
    'rrdtool',
    'sensors',
    'serial',
    'sigrok',
    'smart',
    'snmp',
    'statsd',
    'swap',
    'syslog',
    'table',
    'tail',
    'tail_csv',
    'tape',
    'target_notification',
    'target_replace',
    'target_scale',
    'target_set',
    'target_v5upgrade',
    'tcpconns',
    'teamspeak2',
    'ted',
    'thermal',
    'threshold',
    'tokyotyrant',
    'unixsock',
    'uptime',
    'users',
    'uuid',
    'varnish',
    'virt',
    'vmem',
    'vserver',
    'wireless',
    'write_graphite',
    'write_http',
    'write_kafka',
    'write_mongodb',
    'write_redis',
    'write_riemann',
    'write_tsdb',
    'xmms',
    'zfs_arc',
  ]

}
