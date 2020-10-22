{
  init(name, namespace, host='hub.infra.clgt.io'):: {
    local fullAddressRepo = std.format('%s/ci/%s', [host, name]),
    name: 'deploy_k8s',
    image: 'alpine/k8s:1.18.2',
    environment: {
        KUBECONFIG: {
            from_secret: 'kubeconfig'
        }
    },
    commands: [
//      'mkdir ~/.kube && echo "$KUBECONFIG" > ~/.kube/config', // kubeconfig
      'kubectl apply -f kubernetes --force',
      'kubectl patch deployment '+name+' -p $(printf \'{"spec":{"template":{"metadata":{"annotations":{"date":"%s"}}}}}\' $(awk \'BEGIN {srand(); print srand()}\')) ' + (if namespace != '' then std.format('--namespace=%s', namespace) else ''),
    ],
  },
}
