{
  ApplyResources(dirs):: {
    name: 'apply_kube',
    image: 'alpine/k8s:1.18.2',
    environment: {
        KUBECFG: {
            from_secret: 'kubeconfig'
        }
    },
    commands: [
      'mkdir ~/.kube && echo -n "$KUBECFG" > /root/.kube/config',
      std.format('kubectl apply %s', std.join(",", [std.format('-f %s ', x) for x in dirs if x != ''])),
    ],
  },
}
