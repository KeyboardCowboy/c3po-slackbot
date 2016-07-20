# Description:
#   Queues to c3po to inform about what he can do.
#
# Author:
#    KeyboardCowboy <chris@lullabot.com>
#

config = require('../config.json')

module.exports = (robot) ->
  robot.respond /^help(\!+)?$/i, (res) ->
    response = "Oh no, %name is in trouble! Curse my metal body, I wasn't fast enough, it's all my fault!\n"
    response += "Try one of these commands:\n"
    response += "- *convert* x unit to y (ex. 'convert 5lb to kg')\n"
    response += "- *define* [a word] (ex. 'define robot')\n"
    response += "- *what is* [a thing] (ex. 'what is Kanye') _Note: Do take caution with this one, as your Urban Dictionary provides the data._\n"
    response += "I may also pop in from time to time to help you with everyday conversions and conversation."

    res.send response.replace "%name", res.message.user.name
