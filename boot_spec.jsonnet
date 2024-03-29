local apply = import './deploy/apply.libsonnet';

[
  (import './boot.libsonnet').Boot(name='test_app'),
  (import './boot.libsonnet').Boot(name='test_app', namespace='infra'),
  (import './boot.libsonnet').Combine([apply.ApplyResources(['postgres'])]),
  (import './boot.libsonnet').
      Boot(
          name = "registry",
          namespace = "infrastructure",
          hub="registry.hub.docker.com",
          hubuser="nacud",
          passwordsecret="dockerhubpwd",
          repo="nacud/registry",
      )
]
