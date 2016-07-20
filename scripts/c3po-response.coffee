# Description:
#   C3PO can respond to you!
#
# Listens for:
#   Mentions and greeting keywords.
#
# Author:
#    KeyboardCowboy <chris@lullabot.com>
#

hellos = [
  "It sounds like Han! Oh, hello %.",
  "Well hello there, %.",
  "Good day, %.",
  "If I may say so, sir, I noticed earlier the hyperdrive motivator has been damaged.",
  "Just open the door, you stupid lug!",
  "Well, he seems very friendly.",
  "That sounds like an R2 unit in there! I wonder if... Hello? How interesting.",
  "Use the comlink? Oh my! I forgot, I turned it off. ",
  "Is there anything I can do? ",
  "Did you hear that? They shut down the main reactor."
]
module.exports = (robot) ->
  robot.respond /(hello|hi|hey|goodday)/i, (msg) ->
    hello = msg.random hellos
    msg.send hello.replace "%", msg.message.user.name

  robot.enter (msg) ->
    msg.send "I am C-3PO, human-cyborg relations."
