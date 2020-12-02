{
  init(repo, username, passwordsecret, repo='', host='hub.infra.clgt.io', dockerfile = "Dockerfile"):: {
    local fullAddressRepo = std.format('%s/ci/%s', [host, repo]),
    name: 'docker',
    image: 'plugins/docker',
    settings: {
      registry: host,
      repo: if repo == '' then fullAddressRepo else repo,
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
