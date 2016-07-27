# Description:
#   Look things up in wikipedia.
#
# Listens for:
#   (What|Who)(is|are) things.
#
# Author:
#    KeyboardCowboy <chris@lullabot.com>
#

config = require('../config.json')
speech = require('../speech.json')
wiki = require("wikipedia-js")
slackify = require('slackify-html')

module.exports = (robot) ->
  robot.respond /(who|what) (is|are) (.*)\?/i, (res) ->
    options = {query: res.match[3], format: "html", summaryOnly: true};
    wiki.searchArticle options, (err, content) ->
      if err
        console.log("An error occurred[query=%s, error=%s]", subject, err)
        return
      else
        res.send robot.removeFormatting content
        return


