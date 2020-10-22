local telegram = import './telegram.libsonnet';


{
  steps: [
    telegram.triggerBuild(),
    telegram.successBuild(),
    telegram.failureBuild(),
  ],
}
