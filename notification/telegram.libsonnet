local condition = import '../condition/condition.libsonnet';
local triggerMessage = '🚀 {{repo.name}} triggered build by {{commit.author}} ({{build.event}})\n{{build.link}}';
local successMessage = '';

{
  CHANNEL_ID: '866725700',
  triggerBuild(msg=triggerMessage, to=self.CHANNEL_ID):: {
    name: 'trigger_build',
    image: 'appleboy/drone-telegram',
    settings: {
      message: msg,
      token: {
        from_secret: 'telegramtoken'
      },
      to: to,
    },
  },
  successBuild(msg=triggerMessage, to=self.CHANNEL_ID):: {
    name: 'success_build',
    image: 'appleboy/drone-telegram',
    settings: {
      token: {
        from_secret: 'telegramtoken'
      },
      format: 'html',
      to: to,
    },
  },
  failureBuild(msg=triggerMessage, to=self.CHANNEL_ID):: condition.StatusFailure {
    name: 'failure_build',
    image: 'appleboy/drone-telegram',
    settings: {
      token: {
        from_secret: 'telegramtoken'
      },
      format: 'html',
      to: to,
    },
  },
}
