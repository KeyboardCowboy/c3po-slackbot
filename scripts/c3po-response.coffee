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
  "Well, he seems very friendly.",
  "That sounds like an R2 unit in there! I wonder if... Hello? How interesting.",
  "Use the comlink? Oh my! I forgot, I turned it off. ",
  "Is there anything I can do? ",
  "May the Force be with you.",
  "I do believe they think I am some kind of god.",
  "I'm rather embarrassed, %, but it appears that you are to be the main course at a banquet in my honor.",
  "Wonderful. We are now a part of the tribe.",
  "At last, %'s come to rescue me!",
  "Your Royal Highness.",
  "The maker has returned!",
  "Hello, I am C-3PO, human cyborg relations. How might I serve you?",
  "Excuse me, %, but where are we?",
  "Oh, my dear friend, how I've missed you.",
  "Goodness! %! It is I, C-3PO. You probably don't recognize me because of the red arm."
]
module.exports = (robot) ->
  robot.respond /(hello|hi|hey|goodday)/i, (msg) ->
    hello = msg.random hellos
    msg.send hello.replace "%", msg.message.user.name

  robot.enter (msg) ->
    greeting = "Hello %. I am C-3PO, human-cyborg relations."
    msg.send greeting.replace "%", msg.message.user.name
