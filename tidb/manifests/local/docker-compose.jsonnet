std.manifestYamlDoc({
  version: '3.7',
  services: {
    ['node-%s' % k]: {
      image: 'hub.pingcap.net/qa/jepsen-node:centos7.6',
      hostname: 'node-%s' % k,
      privileged: true,
      volumes: ['./data-%s:/opt' % k],
      environment: {
        AUTHORIZED_KEYS: importstr 'ssh-key.pub'
      },
      networks: {
        jepsen: { ipv4_address: '172.32.1.%s' % k },
      },
    } for k in std.range(1, 5)
  },
  networks: {
    jepsen: {
      // internal: true,
      ipam: {
        driver: 'default',
        config: [ {subnet: '172.32.0.0/16'} ],
      },
    },
  },
})
