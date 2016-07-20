# Description:
#   Hubot commands for lullabot.com.
#
# Configuration:
#   HUBOT_JENKINS_USERNAME
#   HUBOT_JENKINS_API_KEY
#
# Commands:
#   hubot deploy edit:<hash> - Deploys edit.lullabot.com
#   hubot deloy www:<hash> - Deploys www.lullabot.com and preview.lullabot.com
#
# Author:
#    justafish
#
module.exports = (robot) ->
  robot.respond /deploy (.*):(.*)/i, (res) ->
    username = process.env.HUBOT_JENKINS_USERNAME
    apikey = process.env.HUBOT_JENKINS_API_KEY
    request = require('request')
    if (res.match[1] && res.match[2])
      switch res.match[1]
        when 'edit'
          request.post 'https://ci.lullabot.com/view/Lullabot.com/job/edit.lullabot.com_deploy/buildWithParameters?TAG=' + res.match[2], {
            'auth': {
              'user': username,
              'pass': apikey
            }
          }
        when 'www'
          request.post 'https://ci.lullabot.com/view/Lullabot.com/job/www-preview.lullabot.com_deploy/buildWithParameters?GIT_TAG=' + res.match[2], {
            'auth': {
              'user': username,
              'pass': apikey
            }
          }
