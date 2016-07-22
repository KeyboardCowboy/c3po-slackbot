# Description:
#   Integrates C3PO Bot with his github repo.
#
# Dependencies:
#   - Githubot
#
# Commands:
#
#
# Author:
#    KeyboardCowboy <chris@lullabot.com>
#

config = require('../config.json')
github = require('githubot')

# Verify a user's access to github. (Should be just me.)
github_access = (res) ->
  allowed = res.message.user.name == config.github.user
  if !allowed
    response = "I'm terribly sorry, %name, but I am not authorized self-report for you."
    res.send response.replace "%name", res.message.user.name
    res.send "Please try this as an alternative: " + config.github.url.issues
  allowed

module.exports = (robot) ->
  # Report a bug.
  robot.respond /(file|report) a bug\:(.*)/i, (res) ->
    data = {
      'title': res.match[2],
      'labels': ['bug']
    }

    if (github_access res)
      github.post config.github.api.issues, data, (issue) ->
        res.send "So sorry. I've reported the bug for you, sir."
        res.send issue.html_url

  # Report an enhancement.
  robot.respond /(You|I|We) should be able to (.*)/i, (res) ->
    data = {
      'title': res.match[2],
      'labels': ['enhancement']
    }

    if (github_access res)
      github.post config.github.api.issues, data, (issue) ->
        res.send "I agree. I've logged the upgrade request for you, sir."
        res.send issue.html_url
