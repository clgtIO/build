local apply = import './deploy/apply.libsonnet';

[
  (import './boot.libsonnet').Boot(name='test_app'),
  (import './boot.libsonnet').Boot(name='test_app', namespace='infra'),
  (import './boot.libsonnet').Combine([apply.ApplyResources(['postgres'])]),
]
