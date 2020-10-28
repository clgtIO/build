{
  init(name, namespace):: {
    name: 'deploy_k8s',
    image: 'alpine/k8s:1.18.2',
    environment: {
        KUBECFG: {
            from_secret: 'kubeconfig'
        }
    },
    commands: [
      'mkdir ~/.kube && echo -n "$KUBECFG" > /root/.kube/config',
      'kubectl apply -f kubernetes --force',
      'kubectl patch deployment '+name+' -p $(printf \'{"spec":{"template":{"metadata":{"annotations":{"date":"%s"}}}}}\' $(awk \'BEGIN {srand(); print srand()}\')) ' + (if namespace != '' then std.format('--namespace=%s', namespace) else ''),
    ],
  },
}
