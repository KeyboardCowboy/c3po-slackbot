# Description:
#   C3PO can respond to you!
#
# Listens for:
#   Mentions and greeting keywords.
#
# Author:
#    KeyboardCowboy <chris@lullabot.com>
#

config = require('../config.json')
speech = require('../speech.json')

# Send a user some congrats.
congratulate = (name, res, robot) ->
  karmaLog = robot.brain.get('karmaLog') || []

  # Send a basic congrats.
  response = res.random(speech.affirmation).replace "%name", name
  res.send response

  now = new Date()
  last_karma = karmaLog[name] || 0
  give_karma = last_karma < (now.getTime() - (config.time.hours * 1))

  # If we haven't given this user karma in the last hour, do it now.
  if give_karma
    res.send name + "++"
    karmaLog[name] = now.getTime()
    robot.brain.set 'karmaLog', karmaLog


module.exports = (robot) ->
  # Random greeting response.
  robot.respond /(hello|hi|hey|good day)/i, (msg) ->
    msg.send msg.random(speech.greeting).replace "%", msg.message.user.name

  # Random greeting mention.
  robot.hear /(hello|hi|hey|good day)\s+\@c3po/i, (msg) ->
    msg.send msg.random(speech.greeting).replace "%", msg.message.user.name

  # Welcome to the room greeting.
  robot.enter (msg) ->
    greeting = "Hello %. I am C-3PO, human-cyborg relations."
    msg.send greeting.replace "%", msg.message.user.name

  # Respond to thanks.
  robot.hear /(.*)?(thanks|thank you|you\'re the best)(.*)\@c3po(.*)?/i, (res) ->
    res.send res.random(speech.thankyou).replace "%name", res.message.user.name

  # Link to the issue queue.
  robot.respond /(.*)(you\'re broke(n)?|you\'re drunk|fail|wtf[\?\!]+|that\'s wrong)(.*)|(^wtf$)/i, (res) ->
    response = "Oh dear me. Did I do something wrong? Please inform my master immediately.\n"
    response += "https://github.com/KeyboardCowboy/c3po-slackbot/issues"
    res.send response

  # C3PO congratulates and occasionally throws you some karma.
  robot.hear /^(@\w+) (is awesome|kick(s)? ass|rules|nice)(\!+)?$/i, (res) ->
    congratulate(res.match[1], res);
  robot.hear /^(way to go|kick ass|well done|nice|awesome|good job|you\'re the best)[\ \,]+?(@\w+)(\!+)?$/i, (res) ->
    congratulate(res.match[2], res, robot);

  # Niche responses.
  robot.hear /what are the odds/i, (res) ->
    res.send res.random(speech.odds).replace "%name", res.message.user.name
