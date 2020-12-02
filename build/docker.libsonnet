{
  init(repo, username, passwordsecret, host='hub.infra.clgt.io', dockerfile = "Dockerfile"):: {
    local fullAddressRepo = std.format('%s/ci/%s', [host, repo]),
    name: 'docker',
    image: 'plugins/docker',
    settings: {
      registry: host,
      repo: fullAddressRepo,
      username: 'andepzai',
//      purge: true,
      password:  {
        from_secret: passwordsecret,
      },
      dockerfile: dockerfile,
      tags: 'latest'
    },
  },
}
