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

# Build a list of links for a json list of issues.
format_issue_links = (issues) ->
  links = ""
  link = "<%url|%text>"
  for issue in issues
    links += ":small_blue_diamond: " + link.replace("%url", issue.html_url).replace("%text", issue.title) + "\n"
  links


# Verify a user's access to github. (Should be just me.)
github_access = (res) ->
  allowed = res.message.user.name == config.github.user
  if !allowed
    response = "I'm terribly sorry, %name, but I am not authorized self-report for you."
    res.send response.replace "%name", res.message.user.name
    res.send "Please try this as an alternative: " + config.github.url.issues
  allowed

# Do the robot.
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

  # Fetch bugs.
  robot.respond /(What\'s wrong)(\ with you)?\?/i, (res) ->
    data = {labels: ['bug']}
    github.get config.github.api.issues, data, (issues) ->
      count = issues.length
      response = "There's nothing wrong with me.  I am 100% bug free." if count == 0
      response = "Oh just a few things." if count > 0 && count < 5
      response = "Quite a few things, I'm afraid." if count >= 5

      response += "\n" + format_issue_links issues
      res.send response

  # Fetch enhancements.
  robot.respond /(upgrades|improvements|enhancements|what\'s new)\?/i, (res) ->
    data = {labels: ['enhancement']}
    github.get config.github.api.issues, data, (issues) ->
      count = issues.length
      response = "I am not currently scheduled for any upgrades." if count == 0
      response = "I am currently awaiting the following upgrades:" if count > 0

      response += "\n" + format_issue_links issues
      res.send response
