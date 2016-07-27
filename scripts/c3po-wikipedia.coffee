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
      if err || content == ''
        res.send "So sorry.  I'm not sure I know what you mean."
        return
      else
        # Get the first paragraph if this is not a reference list.
        paragraphs = content.split "\n"

        if paragraphs[0].indexOf('may refer to:') == -1
          res.send slackify paragraphs[0] + "\nhttp://en.wikipedia.org/wiki/" + subject
        else
          res.send slackify content + "\nhttp://en.wikipedia.org/wiki/" + subject
