local buildDocker = import './build/docker.libsonnet';
local deployK8S = import './deploy/k8s.libsonnet';
local clone = import './git/clone.jsonnet';
local git = import './git/git.jsonnet';
local tele = import './notification/telegram.libsonnet';

{
  Boot(name, repo = '', namespace='', steps=[], hub='hub.infra.clgt.io', hubuser = 'andepzai', passwordsecret = 'registrypwd'):: [
    {
      clone: { disable: true },
      kind: 'pipeline',
      type: 'docker',
      name: 'notify',
      steps: [tele.triggerBuild()],
    },
    git.disableClone {
      kind: 'pipeline',
      type: 'docker',
      name: 'deploy',
      steps: [
               clone,
             ] +
             steps +
             [
               buildDocker.init(name, host=hub, username=hubuser, passwordsecret=passwordsecret, repo=repo,),
               deployK8S.init(name, namespace),
               tele.successBuild(),
               tele.failureBuild(),
             ],
    },
  ],
  Combine(arr):: [
    {
      clone: { disable: true },
      kind: 'pipeline',
      type: 'docker',
      name: 'notify',
      steps: [tele.triggerBuild()],
    },
    git.disableClone {
      kind: 'pipeline',
      type: 'docker',
      name: 'deploy',
      steps: [
               clone,
             ] + arr +
             [
               tele.successBuild(),
               tele.failureBuild(),
             ],
    },
  ],
}
