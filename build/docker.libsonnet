{
  init(repo, username, passwordsecret, repo2='', host='hub.infra.clgt.io', dockerfile = "Dockerfile"):: {
    local fullAddressRepo = std.format('%s/ci/%s', [host, repo]),
    name: 'docker',
    image: 'plugins/docker',
    settings: {
      registry: host,
      repo: if repo2 == '' then fullAddressRepo else repo2,
      //username: username,
//      purge: true,
      //password:  {
        //from_secret: passwordsecret,
      //},
      dockerfile: dockerfile,
      tags: 'latest'
    },
  },
}
