# Allows you to create cron jobs on script level
# Inspider by https://github.com/miyagawa/hubot-cron

# @author Pavel Vanecek <pavel.vanecek@merck.com>

{ CronJob } = require 'cron'

class HubotCron

  constructor: (@pattern, @timezone, @fn, @context = global) ->
    @cronjob = new CronJob(
      @pattern
      @onTick.bind(this)
      null
      false
      @timezone
    )
    if 'function' != typeof @fn
      throw new Error "the third parameter must be a function, got (#{typeof @fn}) instead"
    @cronjob.start()

  stop: ->
    @cronjob.stop()

  onTick: ->
    Function::call.apply @fn, @context

module.exports = HubotCron
