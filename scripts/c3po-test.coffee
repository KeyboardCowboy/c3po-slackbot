# Description:
#   Print a few test things.
#
# Author:
#    KeyboardCowboy <chris@lullabot.com>
#
module.exports = (robot) ->
  robot.respond /(Print one line)\b/i, (res) ->
    res.send "Here is a single line of text."

  robot.respond /(Print two lines)\b/i, (res) ->
    res.send "Here is a single line of text.\nAnd here is another."
