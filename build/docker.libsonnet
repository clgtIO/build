{
  init(repo, username, passwordsecret, repo2='', host='hub.infra.clgt.io', dockerfile = "Dockerfile", tags = 'latest'):: {
    local fullAddressRepo = std.format('%s/ci/%s', [host, repo]),
    name: 'docker',
    image: 'plugins/docker',
    environment: {
      DOCKER_API_VERSION: '1.38'
    },
    settings: {
      registry: host,
      repo: if repo2 == '' then fullAddressRepo else repo2,
      username: username,
      //insecure: true,
//    purge: true,
      password:  {
        from_secret: passwordsecret,
      },
      dockerfile: dockerfile,
      tags: tags
    },
  },
}
