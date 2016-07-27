# Description:
#   Converts between Celsius and Fahrenheit.
#
# Listens for:
#   int [F|C]
#   int[F|C]
#
# Author:
#    KeyboardCowboy <chris@lullabot.com>
#
convert = require('convert-units')

config = require('../config.json')
speech = require('../speech.json')

# Parse messages to print to slack.
parse_response = (slack, value1, unit1, value2, unit2) ->
  res = slack.random speech.conversions
  res = res.replace '%1', value1 + unit1
  res = res.replace '%2', value2 + unit2
  res = res.replace '%3', slack.message.user.name
  res

module.exports = (robot) ->
  # Convert Fahrenheit.
  robot.hear /(-?\d+(\.\d+)?)(\s+)?(f)\b/i, (msg) ->
    value = msg.match[1]
    converted_value = convert(value).from('F').to('C').toFixed(1);
    msg.send parse_response msg, value, '°F', converted_value, '°C'

  # Convert Celsius.
  robot.hear /(-?\d+(\.\d+)?)(\s+)?(c)\b/i, (msg) ->
    value = msg.match[1]
    converted_value = convert(value).from('C').to('F').toFixed(1);
    msg.send parse_response msg, value, '°C', converted_value, '°F'

  # Convert miles.
  robot.hear /(-?\d+(\.\d+)?)(\s+)?(mile(s)?|mi)\b/i, (msg) ->
    value = msg.match[1]
    converted_value = convert(value).from('mi').to('km').toFixed(2);
    msg.send parse_response msg, value, ' miles', converted_value, ' kilometers'

  # Convert kilometers.
  robot.hear /(-?\d+(\.\d+)?)(\s+)?(kilometer(s)?|km)\b/i, (msg) ->
    value = msg.match[1]
    converted_value = convert(value).from('km').to('mi').toFixed(2);
    msg.send parse_response msg, value, ' kilometers', converted_value, ' miles'

  # Convert rods/hogshead.
  robot.hear /(-?\d+(\.\d+)?) rods( per |\/| to the )hogshead\b/i, (res) ->
    value = res.match[1];
    converted_value = ((value * .0031) / 63).toFixed(4);
    res.send "Mr. Simpson, " + value + " rods to the hogshead is " + converted_value, " miles per gallon."

  # Conversion on demand.
  robot.respond /convert (-?\d+(\.\d+)?)(\s+)?([a-z0-9\-]{1,5}) to ([a-z0-9\-]{1,5})/i, (msg) ->
    value = msg.match[1]
    unit1 = msg.match[4]
    unit2 = msg.match[5]

    try
      converted_value = convert(value).from(unit1).to(unit2).toFixed(2);
      msg.send parse_response msg, value, ' ' + unit1, converted_value, ' ' + unit2
    catch
      response = "Oh dear.  I don't seem to recognize that conversion.  Did you supply the proper units?\n"
      response += "Try one of these: " + convert().possibilities()
      msg.send(response)
