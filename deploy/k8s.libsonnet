{
  init(name, namespace, host='hub.infra.clgt.io'):: {
    local fullAddressRepo = std.format('%s/ci/%s', [host, name]),
    name: 'deploy_k8s',
    image: 'alpine/k8s:1.18.2',
    environment: {
        KUBECFG: {
            from_secret: 'kubeconfig'
        }
    },
    commands: [
      'mkdir ~/.kube && echo -n "$KUBECFG" | base64 -d > /root/.kube/config',
      'echo 123 + $(cat /root/.kube/config | cut -c 1-5)',
      'kubectl apply -f kubernetes --force',
      'kubectl patch deployment '+name+' -p $(printf \'{"spec":{"template":{"metadata":{"annotations":{"date":"%s"}}}}}\' $(awk \'BEGIN {srand(); print srand()}\')) ' + (if namespace != '' then std.format('--namespace=%s', namespace) else ''),
    ],
  },
}
