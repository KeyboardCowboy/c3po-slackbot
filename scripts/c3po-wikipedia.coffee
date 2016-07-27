# Description:
#   Look things up in wikipedia.
#
# Listens for:
#   (What|Who)(is|are) things.
#
# Author:
#    KeyboardCowboy <chris@lullabot.com>
#

wiki = require("wikipedia-js")
slackify = require('slackify-html')

module.exports = (robot) ->
  robot.respond /(who|what) (is|are) (a[n]? )?(.*)\?/i, (res) ->
    subject = res.match[4]
    options = {query: subject, format: "html", summaryOnly: true};
    wiki.searchArticle options, (err, content) ->
      if err
        console.log("An error occurred[query=%s, error=%s]", subject, err)
        return
      else
        # Get the first paragraph.
        paragraphs = content.split "\n"
        res.send slackify paragraphs[0] + "\nhttp://en.wikipedia.org/wiki/" + subject
